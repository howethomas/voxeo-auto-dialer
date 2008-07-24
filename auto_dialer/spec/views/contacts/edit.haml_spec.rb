require File.dirname(__FILE__) + '/../../spec_helper'

describe "/contact/edit.haml" do
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

  it "should render edit form" do
    render "/contacts/edit.haml"
    
    response.should have_tag("form[action=#{contact_path(@contact)}][method=post]") do
      with_tag('input#contact_first_name[name=?]', "contact[first_name]")
      with_tag('input#contact_last_name[name=?]', "contact[last_name]")
      with_tag('input#contact_email[name=?]', "contact[email]")
      with_tag('input#contact_phone[name=?]', "contact[phone]")
      with_tag('input#contact_cell[name=?]', "contact[cell]")
      with_tag('input#contact_address1[name=?]', "contact[address1]")
      with_tag('input#contact_address2[name=?]', "contact[address2]")
      with_tag('input#contact_city[name=?]', "contact[city]")
      with_tag('input#contact_state[name=?]', "contact[state]")
      with_tag('input#contact_country[name=?]', "contact[country]")
      with_tag('input#contact_post_code[name=?]', "contact[post_code]")
      with_tag('input#contact_time_zone[name=?]', "contact[time_zone]")
    end
  end
end