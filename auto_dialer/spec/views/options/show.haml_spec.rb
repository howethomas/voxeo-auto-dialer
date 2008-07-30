require File.dirname(__FILE__) + '/../../spec_helper'

describe "/options/show.haml" do
  include OptionsHelper
  
  before do
    @option = mock_model(Option)
    @option.stub!(:version).and_return("MyString")
    @option.stub!(:mock).and_return(false)
    @option.stub!(:debug_level).and_return("1")
    @option.stub!(:admin_name).and_return("MyString")
    @option.stub!(:admin_email).and_return("MyString")
    @option.stub!(:daily_summary).and_return(false)

    assigns[:option] = @option
  end

  it "should render attributes in <p>" do
    render "/options/show.haml"
    response.should have_text(/MyString/)
    response.should have_text(/als/)
    response.should have_text(/1/)
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/als/)
  end
end

