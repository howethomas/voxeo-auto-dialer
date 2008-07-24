require File.dirname(__FILE__) + '/../../spec_helper'

describe "/application/edit.haml" do
  include ApplicationsHelper
  
  before do
    @application = mock_model(Application)
    @application.stub!(:name).and_return("MyString")
    @application.stub!(:wait_wav).and_return("MyString")
    @application.stub!(:app_human).and_return("MyString")
    @application.stub!(:app_machine).and_return("MyString")
    assigns[:application] = @application
  end

  it "should render edit form" do
    render "/applications/edit.haml"
    
    response.should have_tag("form[action=#{application_path(@application)}][method=post]") do
      with_tag('input#application_name[name=?]', "application[name]")
      with_tag('input#application_wait_wav[name=?]', "application[wait_wav]")
      with_tag('input#application_app_human[name=?]', "application[app_human]")
      with_tag('input#application_app_machine[name=?]', "application[app_machine]")
    end
  end
end