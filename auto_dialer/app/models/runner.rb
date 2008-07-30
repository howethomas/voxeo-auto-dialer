require 'net/http' 
require 'uri' 


class Runner < ActiveRecord::Base
  def self.process_tasks
    kick_off_apps
    kick_off_calls
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
        logger.info("Kicking off a call to #{task.contact.phone}")
        puts("Kicking off a call to #{task.contact.phone}")
        start_call(task)
        task.started = true
        task.completed = false  # Will be marked completed somehow
        task.save
        h = History.new
        h.schedule_id = task.schedule_id
        h.contact_id = task.contact_id
        h.result = "Call Made"
        h.save
      else
        logger.info("Task is going to start in #{task.start-now}")
      end
    end
  end

  def self.start_call(task)
    logger.info("Sending a call to #{task.contact.phone}")
    response = fetch("#{task.app.start_url}&numberToDial=tel:#{task.contact.phone}&humanApp=#{task.app.app_human}&machineApp=#{task.app.app_machine}&beepApp=#{task.app.app_beep}&waitWav=#{task.app.wait_wav}")
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
