require File.dirname(__FILE__) + '/../../spec_helper'

describe "/applications/index.haml" do
  include ApplicationsHelper
  
  before do
    application_98 = mock_model(Application)
    application_98.should_receive(:name).and_return("MyString")
    application_98.should_receive(:wait_wav).and_return("MyString")
    application_98.should_receive(:app_human).and_return("MyString")
    application_98.should_receive(:app_machine).and_return("MyString")
    application_99 = mock_model(Application)
    application_99.should_receive(:name).and_return("MyString")
    application_99.should_receive(:wait_wav).and_return("MyString")
    application_99.should_receive(:app_human).and_return("MyString")
    application_99.should_receive(:app_machine).and_return("MyString")

    assigns[:applications] = [application_98, application_99]
  end

  it "should render list of applications" do
    render "/applications/index.haml"
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
  end
end
