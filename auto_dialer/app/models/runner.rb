class Runner < ActiveRecord::Base
  def self.process_tasks
    kick_off_apps
    kick_off_calls
    clean_up_calls
    clean_up_apps
  end

  def self.kick_off_apps
    # First, let's run through the scheduled tasks, and see if any of them are set to pending
    # and should be starting. If so, create tasks from the schedule
    pending_schedules = Schedule.find_all_by_state(:pending)
    now = Time.now
    
    for schedule in pending_schedules
      if schedule.start > now
        # Looks like it's time to start kicking calls off
        schedule.state=:running
        
        # Get the tags from teh schedule, and find any contact that has these tags.
        # If the tags are null, then take all the contacts.
        tags = schedule.tags
        if tags.nil?
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
          t.start = now + start_delay.minute
          t.started = false
          t.started = false
          t.save
          start_delay += 1/calls_per_minute 
        end
      end        
    end
  end
  
  def self.kick_off_calls
    pending_tasks = Task.find_all_by_started(:false)
    now = Time.now
    
    for task in pending_tasks
      if task.start > Time.now
  end
    
    
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
