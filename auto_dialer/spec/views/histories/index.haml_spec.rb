require File.dirname(__FILE__) + '/../../spec_helper'

describe "/histories/index.haml" do
  include HistoriesHelper
  
  before do
    history_98 = mock_model(History)
    history_98.should_receive(:result).and_return("MyString")
    history_99 = mock_model(History)
    history_99.should_receive(:result).and_return("MyString")

    assigns[:histories] = [history_98, history_99]
  end

  it "should render list of histories" do
    render "/histories/index.haml"
    response.should have_tag("tr>td", "MyString", 2)
  end
end
