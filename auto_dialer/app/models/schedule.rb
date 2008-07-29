class Schedule < ActiveRecord::Base
  belongs_to :account
  belongs_to :app
  has_many :histories
  
  def initialize(params=nil)
    super(nil)
    self.state  ||= "pending" 
  end
  
end