require File.dirname(__FILE__) + '/../spec_helper'

describe Application do
  before(:each) do
    @application = Application.new
  end

  it "should be valid" do
    @application.should be_valid
  end
end
