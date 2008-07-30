class Task < ActiveRecord::Base
  belongs_to :schedule
  belongs_to :app
  belongs_to :contact
  has_one :history
end
