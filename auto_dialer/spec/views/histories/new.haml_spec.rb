require File.dirname(__FILE__) + '/../../spec_helper'

describe "/histories/new.haml" do
  include HistoriesHelper
  
  before do
    @history = mock_model(History)
    @history.stub!(:new_record?).and_return(true)
    @history.stub!(:result).and_return("MyString")
    assigns[:history] = @history
  end

  it "should render new form" do
    render "/histories/new.haml"
    
    response.should have_tag("form[action=?][method=post]", histories_path) do
      with_tag("input#history_result[name=?]", "history[result]")
    end
  end
end
