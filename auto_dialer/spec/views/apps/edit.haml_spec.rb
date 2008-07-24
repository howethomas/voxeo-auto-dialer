require File.dirname(__FILE__) + '/../../spec_helper'

describe "/app/edit.haml" do
  include AppsHelper
  
  before do
    @app = mock_model(App)
    @app.stub!(:name).and_return("MyString")
    @app.stub!(:wait_wav).and_return("MyString")
    @app.stub!(:app_human).and_return("MyString")
    @app.stub!(:app_machine).and_return("MyString")
    assigns[:app] = @app
  end

  it "should render edit form" do
    render "/apps/edit.haml"
    
    response.should have_tag("form[action=#{app_path(@app)}][method=post]") do
      with_tag('input#app_name[name=?]', "app[name]")
      with_tag('input#app_wait_wav[name=?]', "app[wait_wav]")
      with_tag('input#app_app_human[name=?]', "app[app_human]")
      with_tag('input#app_app_machine[name=?]', "app[app_machine]")
    end
  end
end