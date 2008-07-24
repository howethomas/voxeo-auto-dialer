require File.dirname(__FILE__) + '/../spec_helper'

describe Schedule do
  before(:each) do
    @schedule = Schedule.new
  end

  it "should be valid" do
    @schedule.should be_valid
  end
end
