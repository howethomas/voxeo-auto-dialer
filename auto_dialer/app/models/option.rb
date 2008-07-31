class Option < ActiveRecord::Base

  belongs_to :account
  validates_presence_of :debug_level, :admin_name, :admin_email, :admin_phone
  validates_numericality_of :debug_level
end