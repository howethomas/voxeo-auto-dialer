require File.dirname(__FILE__) + '/../../spec_helper'

describe "/apps/new.haml" do
  include AppsHelper
  
  before do
    @app = mock_model(App)
    @app.stub!(:new_record?).and_return(true)
    @app.stub!(:name).and_return("MyString")
    @app.stub!(:wait_wav).and_return("MyString")
    @app.stub!(:app_human).and_return("MyString")
    @app.stub!(:app_machine).and_return("MyString")
    assigns[:app] = @app
  end

  it "should render new form" do
    render "/apps/new.haml"
    
    response.should have_tag("form[action=?][method=post]", apps_path) do
      with_tag("input#app_name[name=?]", "app[name]")
      with_tag("input#app_wait_wav[name=?]", "app[wait_wav]")
      with_tag("input#app_app_human[name=?]", "app[app_human]")
      with_tag("input#app_app_machine[name=?]", "app[app_machine]")
    end
  end
end
