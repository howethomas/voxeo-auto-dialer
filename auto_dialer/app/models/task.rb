class Task < ActiveRecord::Base
  belongs_to :schedule
  belongs_to :app
  belongs_to :contact
  has_one :history
  
  def self.unfinished_tasks
    Task.find_all_by_completed(false)
  end
  def self.count_unfinished_tasks
    unfinished_tasks.size
  end
end
