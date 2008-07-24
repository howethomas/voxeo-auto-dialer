require File.dirname(__FILE__) + '/../../spec_helper'

describe "/groups/show.haml" do
  include GroupsHelper
  
  before do
    @group = mock_model(Group)
    @group.stub!(:name).and_return("MyString")
    @group.stub!(:enabled).and_return(false)

    assigns[:group] = @group
  end

  it "should render attributes in <p>" do
    render "/groups/show.haml"
    response.should have_text(/MyString/)
    response.should have_text(/als/)
  end
end

