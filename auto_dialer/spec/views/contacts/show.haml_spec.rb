require File.dirname(__FILE__) + '/../../spec_helper'

describe "/contacts/show.haml" do
  include ContactsHelper
  
  before do
    @contact = mock_model(Contact)
    @contact.stub!(:first_name).and_return("MyString")
    @contact.stub!(:last_name).and_return("MyString")
    @contact.stub!(:email).and_return("MyString")
    @contact.stub!(:phone).and_return("MyString")
    @contact.stub!(:cell).and_return("MyString")
    @contact.stub!(:address1).and_return("MyString")
    @contact.stub!(:address2).and_return("MyString")
    @contact.stub!(:city).and_return("MyString")
    @contact.stub!(:state).and_return("MyString")
    @contact.stub!(:country).and_return("MyString")
    @contact.stub!(:post_code).and_return("MyString")
    @contact.stub!(:time_zone).and_return("MyString")

    assigns[:contact] = @contact
  end

  it "should render attributes in <p>" do
    render "/contacts/show.haml"
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
  end
end

