require File.dirname(__FILE__) + '/../../spec_helper'

describe "/schedule/edit.haml" do
  include SchedulesHelper
  
  before do
    @schedule = mock_model(Schedule)
    @schedule.stub!(:start).and_return(Time.now)
    assigns[:schedule] = @schedule
  end

  it "should render edit form" do
    render "/schedules/edit.haml"
    
    response.should have_tag("form[action=#{schedule_path(@schedule)}][method=post]") do
    end
  end
end