class Contact < ActiveRecord::Base
  has_and_belongs_to_many :groups
  has_and_belongs_to_many :schedules
  has_many :histories
  belongs_to :account
end
