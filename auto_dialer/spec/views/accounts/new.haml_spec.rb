require File.dirname(__FILE__) + '/../../spec_helper'

describe "/accounts/new.haml" do
  include AccountsHelper
  
  before do
    @account = mock_model(Account)
    @account.stub!(:new_record?).and_return(true)
    @account.stub!(:name).and_return("MyString")
    @account.stub!(:enabled).and_return(false)
    assigns[:account] = @account
  end

  it "should render new form" do
    render "/accounts/new.haml"
    
    response.should have_tag("form[action=?][method=post]", accounts_path) do
      with_tag("input#account_name[name=?]", "account[name]")
      with_tag("input#account_enabled[name=?]", "account[enabled]")
    end
  end
end
