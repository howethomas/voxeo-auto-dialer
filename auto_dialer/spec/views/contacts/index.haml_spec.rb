require File.dirname(__FILE__) + '/../../spec_helper'

describe "/contacts/index.haml" do
  include ContactsHelper
  
  before do
    contact_98 = mock_model(Contact)
    contact_98.should_receive(:first_name).and_return("MyString")
    contact_98.should_receive(:last_name).and_return("MyString")
    contact_98.should_receive(:email).and_return("MyString")
    contact_98.should_receive(:phone).and_return("MyString")
    contact_98.should_receive(:cell).and_return("MyString")
    contact_98.should_receive(:address1).and_return("MyString")
    contact_98.should_receive(:address2).and_return("MyString")
    contact_98.should_receive(:city).and_return("MyString")
    contact_98.should_receive(:state).and_return("MyString")
    contact_98.should_receive(:country).and_return("MyString")
    contact_98.should_receive(:post_code).and_return("MyString")
    contact_98.should_receive(:time_zone).and_return("MyString")
    contact_99 = mock_model(Contact)
    contact_99.should_receive(:first_name).and_return("MyString")
    contact_99.should_receive(:last_name).and_return("MyString")
    contact_99.should_receive(:email).and_return("MyString")
    contact_99.should_receive(:phone).and_return("MyString")
    contact_99.should_receive(:cell).and_return("MyString")
    contact_99.should_receive(:address1).and_return("MyString")
    contact_99.should_receive(:address2).and_return("MyString")
    contact_99.should_receive(:city).and_return("MyString")
    contact_99.should_receive(:state).and_return("MyString")
    contact_99.should_receive(:country).and_return("MyString")
    contact_99.should_receive(:post_code).and_return("MyString")
    contact_99.should_receive(:time_zone).and_return("MyString")

    assigns[:contacts] = [contact_98, contact_99]
  end

  it "should render list of contacts" do
    render "/contacts/index.haml"
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
  end
end
