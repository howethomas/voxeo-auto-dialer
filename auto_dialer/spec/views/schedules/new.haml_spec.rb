require File.dirname(__FILE__) + '/../../spec_helper'

describe "/schedules/new.haml" do
  include SchedulesHelper
  
  before do
    @schedule = mock_model(Schedule)
    @schedule.stub!(:new_record?).and_return(true)
    @schedule.stub!(:start).and_return(Time.now)
    assigns[:schedule] = @schedule
  end

  it "should render new form" do
    render "/schedules/new.haml"
    
    response.should have_tag("form[action=?][method=post]", schedules_path) do
    end
  end
end
