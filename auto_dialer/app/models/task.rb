class Task < ActiveRecord::Base
  belongs_to :schedule
  belongs_to :application
  has_one :history
end
