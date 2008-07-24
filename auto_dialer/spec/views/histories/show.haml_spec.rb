require File.dirname(__FILE__) + '/../../spec_helper'

describe "/histories/show.haml" do
  include HistoriesHelper
  
  before do
    @history = mock_model(History)
    @history.stub!(:result).and_return("MyString")

    assigns[:history] = @history
  end

  it "should render attributes in <p>" do
    render "/histories/show.haml"
    response.should have_text(/MyString/)
  end
end

