require File.dirname(__FILE__) + '/../spec_helper'

describe Contact do
  before(:each) do
    @contact = Contact.new
  end

  it "should be valid" do
    @contact.should be_valid
  end
end
