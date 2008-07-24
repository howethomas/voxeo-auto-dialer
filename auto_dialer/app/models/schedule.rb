class Schedule < ActiveRecord::Base
  belongs_to :account
  belongs_to :application
  has_many :histories
end