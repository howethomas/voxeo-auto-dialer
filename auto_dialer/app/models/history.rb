class History < ActiveRecord::Base
  belongs_to :contact
  belongs_to :schedule
  belongs_to :task
  def self.count_calls_since(since_time)
     History.find(:all, :conditions => ["created_at > :time", { :time => (Time.zone.now - since_time)}]).size
  end
end