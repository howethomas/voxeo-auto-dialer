class Option < ActiveRecord::Base

  belongs_to :account
  validates_presence_of :debug_level
  validates_numericality_of :debug_level
end