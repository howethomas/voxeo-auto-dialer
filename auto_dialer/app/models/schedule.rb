class Schedule < ActiveRecord::Base
  belongs_to :account
  belongs_to :app
  has_many :histories
    
  def validate 
    unless start > Time.zone.now - 1.minute   
      errors.add(:start, " is in the past.") 
    end 
  end 
  
  def initialize(params=nil)
    super(nil)
    self.state  ||= "pending" 
  end
  
  def total_tasks
    Task.find_all_by_schedule_id(self.id).size
  end
  
  def tasks_left
    Task.find(:all, :conditions => ["schedule_id = ? and completed = 'f'", self.id]).size
  end
end