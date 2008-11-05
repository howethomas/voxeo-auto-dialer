class Schedule < ActiveRecord::Base
  belongs_to :account
  belongs_to :app
  has_many :histories
  validates_presence_of :start, :on => :create, :message => "can't be blank"
  validates_presence_of :app_id, :on => :save, :message => "can't be blank" 
  
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
  
  def before_destroy
    puts "Destroying the schedule"
    tasks = Task.find_all_by_schedule_id(self.id)
    if tasks
      tasks.each {|t| t.destroy}
    end
  end
end