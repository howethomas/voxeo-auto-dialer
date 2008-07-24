require File.dirname(__FILE__) + '/../../spec_helper'

describe "/history/edit.haml" do
  include HistoriesHelper
  
  before do
    @history = mock_model(History)
    @history.stub!(:result).and_return("MyString")
    assigns[:history] = @history
  end

  it "should render edit form" do
    render "/histories/edit.haml"
    
    response.should have_tag("form[action=#{history_path(@history)}][method=post]") do
      with_tag('input#history_result[name=?]', "history[result]")
    end
  end
end