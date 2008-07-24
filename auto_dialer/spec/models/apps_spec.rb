require File.dirname(__FILE__) + '/../spec_helper'

describe App do
  before(:each) do
    @app = App.new
  end

  it "should be valid" do
    @app.should be_valid
  end
end
