require 'net/http' 
require 'uri' 


class Runner < ActiveRecord::Base
  @debug_level=0
  @RUNNER_LOGGER
    
  def self.process_tasks
    kick_off_apps
    kick_off_calls
   end

  def self.debug(msg)
    if @debug_level > 0
      text = "RUNNER : #{Time.zone.now} : " + msg
      logger.debug(text)
      @RUNNER_LOGGER.debug(text)
      puts text
    end
  end
  
  def self.do_loop
    @RUNNER_LOGGER = Logger.new("#{RAILS_ROOT}/log/engine.log")
    @RUNNER_LOGGER.level = Logger::DEBUG
    ticks=0
    
    begin
      loop do
        option = Option.first
        @debug_level = option.debug_level
        kick_off_calls
        debug("Tick #{ticks}")
        debug("Not sending calls. Mock enabled") if option.mock
        case ticks.modulo(6)
          when 0 :
            kick_off_apps
            debug("Kicked off apps") 
          when 1:
            complete_schedule
            debug("Looked for completed schedules") 
        end
        ticks += 1
        debug("Sleeping")
        sleep 10
      end
    rescue Exception => e
      debug("Caught an exception! " + e.message + "\n" + e.backtrace.join("\n"))
      puts "Waiting to restart in "
      seconds = 5
      5.times do
         puts "#{seconds} seconds\n"
         seconds -= 1
         sleep 1
       end
      retry
    end
    
  end
  
  def self.kick_off_apps
    # First, let's run through the scheduled tasks, and see if any of them are set to pending
    # and should be starting. If so, create tasks from the schedule
    pending_schedules = Schedule.find_all_by_state("pending")
    now = Time.zone.now
    debug("Found #{pending_schedules.size} applications pending")
    for schedule in pending_schedules
      debug("Looking to see if #{schedule.start} is before #{now}")
      if schedule.start < now
        # Looks like it's time to start kicking calls off
        debug("Starting app #{schedule.app.name}")
        schedule.state="running"
        if schedule.valid?
          schedule.save
        else
          debug("Could not save the schedule #{schedule.inspect}")
          debug("")
        end
        
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
          debug("Starting a new task #{t.id} to fire at #{t.start}") 
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
        debug("Kicking off a call to #{task.contact.phone}")
        task.started=true
        start_call(task.app, task.contact.phone, h.id, task.contact)
        task.completed=true
        task.save
        debug("Just completed task #{task.id}")
      else
        debug("Task is going to start in #{task.start-now}")
      end
    end
  end

  def self.start_call(app, phone, history_id=nil, contact=nil)
    option = Option.first
        
    # We need to build the URL.  First, the base is always the same...
    call_url = "#{URI.escape(app.start_url)}&numberToDial=tel:#{URI.escape(phone.strip)}"
    call_url += "&humanApp=#{URI.escape(app.app_human.strip)}" if app.app_human
    call_url += "&machineApp=#{URI.escape(app.app_machine.strip)}" if app.app_machine
    call_url += "&beepApp=#{URI.escape(app.app_beep.strip)}" if app.app_beep
    call_url += "&waitWav=#{URI.escape(app.wait_wav.strip)}" if app.wait_wav
    
    if contact
      # Now, add the options...
      options = app.fields.split
      for o in options do
        data = contact.send(o)
        if data and data.class == String
          data.strip!
        end
        call_url += "&#{o}=#{data}"
      end
    end
    
    if history_id
      call_url += "&history_id=#{history_id}"
    end
    logger.info("Sending call to #{call_url}")
    unless option.mock
      response = fetch(call_url)
    else
      debug "No fetch. Application is in mock mode. To change, visit the option menu and uncheck 'mock'."
    end
  end
  
  
  def self.fetch(uri_str, limit=10) 
    fail 'http redirect too deep' if limit.zero? 
    debug "Trying: #{uri_str}" 
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
    debug("Found #{running_schedules.size} applications running")
    for schedule in running_schedules
      tasks = schedule.tasks_left
      debug("The schedule started at #{schedule.start} has #{tasks} tasks left.")
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
