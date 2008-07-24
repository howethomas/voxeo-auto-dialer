require File.dirname(__FILE__) + '/../../spec_helper'

describe "/accounts/show.haml" do
  include AccountsHelper
  
  before do
    @account = mock_model(Account)
    @account.stub!(:name).and_return("MyString")
    @account.stub!(:enabled).and_return(false)

    assigns[:account] = @account
  end

  it "should render attributes in <p>" do
    render "/accounts/show.haml"
    response.should have_text(/MyString/)
    response.should have_text(/als/)
  end
end

