require 'net/http' 
require 'uri' 


class Runner < ActiveRecord::Base
  def self.process_tasks
    kick_off_apps
    kick_off_calls
   end

  def self.do_loop
    ticks=0
    loop do
      option = Option.first
      kick_off_calls
      logger.debug("Kicked off calls") if option.debug_level > 0
      logger.debug("Not sending calls. Mock enabled") if option.mock
      case ticks.modulo(6)
        when 0 :
          kick_off_apps
          logger.debug("Kicked off apps") if option.debug_level > 0
        when 1:
          complete_schedule
          logger.debug("Looked for completed schedules") if option.debug_level > 0
      end
      ticks += 1
      logger.debug("Sleeping") if option.debug_level > 0
      sleep 10
    end
  end
  
  def self.kick_off_apps
    # First, let's run through the scheduled tasks, and see if any of them are set to pending
    # and should be starting. If so, create tasks from the schedule
    pending_schedules = Schedule.find_all_by_state("pending")
    now = Time.zone.now
    logger.info("Found #{pending_schedules.size} applications pending")
    for schedule in pending_schedules
      logger.info("Looking to see if #{schedule.start} is before #{now}")
      if schedule.start < now
        # Looks like it's time to start kicking calls off
        logger.info("Starting app #{schedule.app.name}")
        schedule.state="running"
        schedule.save
        
        # Get the tags from teh schedule, and find any contact that has these tags.
        # If the tags are null, then take all the contacts.
        tags = schedule.tags
        if tags.nil? || tags.empty?
          recipients = Contact.find(:all)
        else
          recipients = Array.new
          for tag in tags.split do
            recipients += Contact.find(:all, :conditions => ["tags like ?", "%#{tag}%"])
          end
          # We might have picked the same contact twice. All we need is one.
          recipients.uniq!
        end
        
        # Now, schedule a call for each of these contacts.
        calls_per_minute = schedule.app.calls_per_minute
        start_delay = 0
        for r in recipients
          t = Task.new
          t.schedule_id = schedule.id
          t.app_id = schedule.app.id
          t.contact_id = r.id
          t.start = now + start_delay.minute
          t.started = false
          t.completed = false
          t.save
          logger.info("Starting a new task to fire at #{t.start}") 
          start_delay += 1.0/calls_per_minute 
        end
      end        
    end
  end
  
  def self.kick_off_calls
    pending_tasks = Task.find_all_by_started(false)
    now = Time.zone.now
    
    for task in pending_tasks
      if task.start < now
        h = History.new
        h.schedule_id = task.schedule_id
        h.contact_id = task.contact_id
        h.result = "Sent to Server"
        h.save
        logger.info("Kicking off a call to #{task.contact.phone}")
        puts("Kicking off a call to #{task.contact.phone}")
        task.started=true
        start_call(task.app, task.contact.phone, h.id)
        task.completed=true
        task.save
      else
        logger.info("Task is going to start in #{task.start-now}")
      end
    end
  end

  def self.start_call(app, phone, history_id=nil)
    option = Option.first
    unless option.mock
      logger.info("Sending a call to #{phone}")
      if history_id.nil?
        response = fetch("#{app.start_url}&numberToDial=tel:#{phone}&humanApp=#{app.app_human}&machineApp=#{app.app_machine}&beepApp=#{app.app_beep}&waitWav=#{app.wait_wav}")
      else
        response = fetch("#{app.start_url}&numberToDial=tel:#{phone}&humanApp=#{app.app_human}&machineApp=#{app.app_machine}&beepApp=#{app.app_beep}&waitWav=#{app.wait_wav}&taskID=#{history_id}")        
      end
      puts response.body
    else
      puts "No call is going to #{phone}. Application is in mock mode. To change, visit the option menu and uncheck 'mock'."
    end
  end
  
  
  def self.fetch(uri_str, limit=10) 
    fail 'http redirect too deep' if limit.zero? 
    puts "Trying: #{uri_str}" 
    response = Net::HTTP.get_response(URI.parse(uri_str)) 
    case response 
      when Net::HTTPSuccess 
        response 
      when Net::HTTPRedirection 
        fetch(response['location'], limit-1) 
      else 
        response.error! 
      end 
  end 
  
  def self.complete_schedule
    running_schedules = Schedule.find_all_by_state("running")
    now = Time.zone.now
    logger.info("Found #{running_schedules.size} applications running")
    for schedule in running_schedules
      tasks = schedule.tasks_left
      logger.info("The schedule started at #{schedule.start} has #{tasks} tasks left.")
      if tasks == 0
        schedule.state = "completed"
        schedule.save
      end
    end
    
  end
  def self.clean_up_calls
    completed_tasks = Task.find_all_by_completed(true)
  end  

  def self.kill_tasks
    Task.delete_all
  end
  def self.start_clean
    kill_tasks
    process_tasks
  end
  def self.show_tasks
    t = Task.find(:all)
    for task in t do
      t.inspect
    end
  end
  def self.show_contacts
    c = Contact.find(:all)
    for person in c do
      puts "\n--"
      puts person.inspect
    end
  end
end
