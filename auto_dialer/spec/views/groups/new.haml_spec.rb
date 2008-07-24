require File.dirname(__FILE__) + '/../../spec_helper'

describe "/groups/new.haml" do
  include GroupsHelper
  
  before do
    @group = mock_model(Group)
    @group.stub!(:new_record?).and_return(true)
    @group.stub!(:name).and_return("MyString")
    @group.stub!(:enabled).and_return(false)
    assigns[:group] = @group
  end

  it "should render new form" do
    render "/groups/new.haml"
    
    response.should have_tag("form[action=?][method=post]", groups_path) do
      with_tag("input#group_name[name=?]", "group[name]")
      with_tag("input#group_enabled[name=?]", "group[enabled]")
    end
  end
end
