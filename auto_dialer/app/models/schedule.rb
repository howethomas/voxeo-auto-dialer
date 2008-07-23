class Schedule < ActiveRecord::Base
  has_and_belongs_to_many :groups
  has_and_belongs_to_many :contacts
  belongs_to :account
  belongs_to :application
  has_many :histories
end
