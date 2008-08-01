require File.dirname(__FILE__) + '/../test_helper'

class ScheduleTest < ActiveSupport::TestCase
  def test_should_not_be_valid_without_a_start_time
    schedule = create(:start => nil)
    deny schedule.valid?
  end
  
  def test_should_not_be_valid_when_starting_in_the_past
    schedule = create
    schedule.start = Time.zone.now - 10.minutes
    assert !schedule.valid?
  end
  
  def test_should_have_application_id
    schedule = create
    schedule.start = Time.zone.now
    deny(schedule.valid?,"Schedule should not be valid")
    schedule.app_id = 100
    assert(schedule.valid?, "Schedule should be valid now")
  end
  
private
  def create(options={})
    Schedule.create(@@schedule_default_values.merge(options))
  end
  
end
