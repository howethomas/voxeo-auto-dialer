require File.dirname(__FILE__) + '/../../spec_helper'

describe "/apps/show.haml" do
  include AppsHelper
  
  before do
    @app = mock_model(App)
    @app.stub!(:name).and_return("MyString")
    @app.stub!(:wait_wav).and_return("MyString")
    @app.stub!(:app_human).and_return("MyString")
    @app.stub!(:app_machine).and_return("MyString")

    assigns[:app] = @app
  end

  it "should render attributes in <p>" do
    render "/apps/show.haml"
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
  end
end

