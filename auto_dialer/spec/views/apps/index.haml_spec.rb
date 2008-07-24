require File.dirname(__FILE__) + '/../../spec_helper'

describe "/apps/index.haml" do
  include AppsHelper
  
  before do
    app_98 = mock_model(App)
    app_98.should_receive(:name).and_return("MyString")
    app_98.should_receive(:wait_wav).and_return("MyString")
    app_98.should_receive(:app_human).and_return("MyString")
    app_98.should_receive(:app_machine).and_return("MyString")
    app_99 = mock_model(App)
    app_99.should_receive(:name).and_return("MyString")
    app_99.should_receive(:wait_wav).and_return("MyString")
    app_99.should_receive(:app_human).and_return("MyString")
    app_99.should_receive(:app_machine).and_return("MyString")

    assigns[:apps] = [app_98, app_99]
  end

  it "should render list of apps" do
    render "/apps/index.haml"
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
  end
end
