class History < ActiveRecord::Base
  belongs_to :contact
  belongs_to :schedule
  belongs_to :task
end
