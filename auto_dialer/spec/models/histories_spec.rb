require File.dirname(__FILE__) + '/../spec_helper'

describe History do
  before(:each) do
    @history = History.new
  end

  it "should be valid" do
    @history.should be_valid
  end
end
