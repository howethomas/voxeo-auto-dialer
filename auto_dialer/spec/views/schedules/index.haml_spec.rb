require File.dirname(__FILE__) + '/../../spec_helper'

describe "/schedules/index.haml" do
  include SchedulesHelper
  
  before do
    schedule_98 = mock_model(Schedule)
    schedule_98.should_receive(:start).and_return(Time.now)
    schedule_99 = mock_model(Schedule)
    schedule_99.should_receive(:start).and_return(Time.now)

    assigns[:schedules] = [schedule_98, schedule_99]
  end

  it "should render list of schedules" do
    render "/schedules/index.haml"
  end
end
