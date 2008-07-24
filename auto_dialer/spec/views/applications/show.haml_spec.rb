require File.dirname(__FILE__) + '/../../spec_helper'

describe "/applications/show.haml" do
  include ApplicationsHelper
  
  before do
    @application = mock_model(Application)
    @application.stub!(:name).and_return("MyString")
    @application.stub!(:wait_wav).and_return("MyString")
    @application.stub!(:app_human).and_return("MyString")
    @application.stub!(:app_machine).and_return("MyString")

    assigns[:application] = @application
  end

  it "should render attributes in <p>" do
    render "/applications/show.haml"
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
  end
end

