class App < ActiveRecord::Base
  belongs_to :account
  has_many :schedules
  has_many :tasks
end