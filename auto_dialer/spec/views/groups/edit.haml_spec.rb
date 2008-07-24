require File.dirname(__FILE__) + '/../../spec_helper'

describe "/group/edit.haml" do
  include GroupsHelper
  
  before do
    @group = mock_model(Group)
    @group.stub!(:name).and_return("MyString")
    @group.stub!(:enabled).and_return(false)
    assigns[:group] = @group
  end

  it "should render edit form" do
    render "/groups/edit.haml"
    
    response.should have_tag("form[action=#{group_path(@group)}][method=post]") do
      with_tag('input#group_name[name=?]', "group[name]")
      with_tag('input#group_enabled[name=?]', "group[enabled]")
    end
  end
end