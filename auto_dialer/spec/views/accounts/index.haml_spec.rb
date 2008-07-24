require File.dirname(__FILE__) + '/../../spec_helper'

describe "/accounts/index.haml" do
  include AccountsHelper
  
  before do
    account_98 = mock_model(Account)
    account_98.should_receive(:name).and_return("MyString")
    account_98.should_receive(:enabled).and_return(false)
    account_99 = mock_model(Account)
    account_99.should_receive(:name).and_return("MyString")
    account_99.should_receive(:enabled).and_return(false)

    assigns[:accounts] = [account_98, account_99]
  end

  it "should render list of accounts" do
    render "/accounts/index.haml"
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", false, 2)
  end
end
