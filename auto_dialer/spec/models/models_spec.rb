require File.dirname(__FILE__) + '/../spec_helper'

describe Model do
  before(:each) do
    @model = Model.new
  end

  it "should be valid" do
    @model.should be_valid
  end
end
