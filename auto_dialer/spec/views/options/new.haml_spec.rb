require File.dirname(__FILE__) + '/../../spec_helper'

describe "/options/new.haml" do
  include OptionsHelper
  
  before do
    @option = mock_model(Option)
    @option.stub!(:new_record?).and_return(true)
    @option.stub!(:version).and_return("MyString")
    @option.stub!(:mock).and_return(false)
    @option.stub!(:debug_level).and_return("1")
    @option.stub!(:admin_name).and_return("MyString")
    @option.stub!(:admin_email).and_return("MyString")
    @option.stub!(:daily_summary).and_return(false)
    assigns[:option] = @option
  end

  it "should render new form" do
    render "/options/new.haml"
    
    response.should have_tag("form[action=?][method=post]", options_path) do
      with_tag("input#option_version[name=?]", "option[version]")
      with_tag("input#option_mock[name=?]", "option[mock]")
      with_tag("input#option_debug_level[name=?]", "option[debug_level]")
      with_tag("input#option_admin_name[name=?]", "option[admin_name]")
      with_tag("input#option_admin_email[name=?]", "option[admin_email]")
      with_tag("input#option_daily_summary[name=?]", "option[daily_summary]")
    end
  end
end
