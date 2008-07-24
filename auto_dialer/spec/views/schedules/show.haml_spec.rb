require File.dirname(__FILE__) + '/../../spec_helper'

describe "/schedules/show.haml" do
  include SchedulesHelper
  
  before do
    @schedule = mock_model(Schedule)
    @schedule.stub!(:start).and_return(Time.now)

    assigns[:schedule] = @schedule
  end

  it "should render attributes in <p>" do
    render "/schedules/show.haml"
  end
end

