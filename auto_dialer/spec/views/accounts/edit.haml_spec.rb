require File.dirname(__FILE__) + '/../../spec_helper'

describe "/account/edit.haml" do
  include AccountsHelper
  
  before do
    @account = mock_model(Account)
    @account.stub!(:name).and_return("MyString")
    @account.stub!(:enabled).and_return(false)
    assigns[:account] = @account
  end

  it "should render edit form" do
    render "/accounts/edit.haml"
    
    response.should have_tag("form[action=#{account_path(@account)}][method=post]") do
      with_tag('input#account_name[name=?]', "account[name]")
      with_tag('input#account_enabled[name=?]', "account[enabled]")
    end
  end
end