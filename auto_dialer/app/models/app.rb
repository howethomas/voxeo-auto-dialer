class App < ActiveRecord::Base
  belongs_to :account
  validates_presence_of :name, :wait_wav, :app_human, :app_machine, :start_url, :app_beep, :calls_per_minute
  validates_numericality_of :calls_per_minute
  validates_uniqueness_of  :name
end