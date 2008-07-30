require File.dirname(__FILE__) + '/../../spec_helper'

describe "/options/index.haml" do
  include OptionsHelper
  
  before do
    option_98 = mock_model(Option)
    option_98.should_receive(:version).and_return("MyString")
    option_98.should_receive(:mock).and_return(false)
    option_98.should_receive(:debug_level).and_return("1")
    option_98.should_receive(:admin_name).and_return("MyString")
    option_98.should_receive(:admin_email).and_return("MyString")
    option_98.should_receive(:daily_summary).and_return(false)
    option_99 = mock_model(Option)
    option_99.should_receive(:version).and_return("MyString")
    option_99.should_receive(:mock).and_return(false)
    option_99.should_receive(:debug_level).and_return("1")
    option_99.should_receive(:admin_name).and_return("MyString")
    option_99.should_receive(:admin_email).and_return("MyString")
    option_99.should_receive(:daily_summary).and_return(false)

    assigns[:options] = [option_98, option_99]
  end

  it "should render list of options" do
    render "/options/index.haml"
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", false, 2)
    response.should have_tag("tr>td", "1", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", false, 2)
  end
end
