require File.dirname(__FILE__) + '/../spec_helper'

describe GroupsController, "#route_for" do

  it "should map { :controller => 'groups', :action => 'index' } to /groups" do
    route_for(:controller => "groups", :action => "index").should == "/groups"
  end
  
  it "should map { :controller => 'groups', :action => 'new' } to /groups/new" do
    route_for(:controller => "groups", :action => "new").should == "/groups/new"
  end
  
  it "should map { :controller => 'groups', :action => 'show', :id => 1 } to /groups/1" do
    route_for(:controller => "groups", :action => "show", :id => 1).should == "/groups/1"
  end
  
  it "should map { :controller => 'groups', :action => 'edit', :id => 1 } to /groups/1/edit" do
    route_for(:controller => "groups", :action => "edit", :id => 1).should == "/groups/1/edit"
  end
  
  it "should map { :controller => 'groups', :action => 'update', :id => 1} to /groups/1" do
    route_for(:controller => "groups", :action => "update", :id => 1).should == "/groups/1"
  end
  
  it "should map { :controller => 'groups', :action => 'destroy', :id => 1} to /groups/1" do
    route_for(:controller => "groups", :action => "destroy", :id => 1).should == "/groups/1"
  end
  
end

describe GroupsController, "handling GET /groups" do

  before do
    @group = mock_model(Group)
    Group.stub!(:find).and_return([@group])
  end
  
  def do_get
    get :index
  end
  
  it "should be successful" do
    do_get
    response.should be_success
  end

  it "should render index template" do
    do_get
    response.should render_template('index')
  end
  
  it "should find all groups" do
    Group.should_receive(:find).with(:all).and_return([@group])
    do_get
  end
  
  it "should assign the found groups for the view" do
    do_get
    assigns[:groups].should == [@group]
  end
end

describe GroupsController, "handling GET /groups.xml" do

  before do
    @group = mock_model(Group, :to_xml => "XML")
    Group.stub!(:find).and_return(@group)
  end
  
  def do_get
    @request.env["HTTP_ACCEPT"] = "application/xml"
    get :index
  end
  
  it "should be successful" do
    do_get
    response.should be_success
  end

  it "should find all groups" do
    Group.should_receive(:find).with(:all).and_return([@group])
    do_get
  end
  
  it "should render the found group as xml" do
    @group.should_receive(:to_xml).and_return("XML")
    do_get
    response.body.should == "XML"
  end
end

describe GroupsController, "handling GET /groups/1" do

  before do
    @group = mock_model(Group)
    Group.stub!(:find).and_return(@group)
  end
  
  def do_get
    get :show, :id => "1"
  end

  it "should be successful" do
    do_get
    response.should be_success
  end
  
  it "should render show template" do
    do_get
    response.should render_template('show')
  end
  
  it "should find the group requested" do
    Group.should_receive(:find).with("1").and_return(@group)
    do_get
  end
  
  it "should assign the found group for the view" do
    do_get
    assigns[:group].should equal(@group)
  end
end

describe GroupsController, "handling GET /groups/1.xml" do

  before do
    @group = mock_model(Group, :to_xml => "XML")
    Group.stub!(:find).and_return(@group)
  end
  
  def do_get
    @request.env["HTTP_ACCEPT"] = "application/xml"
    get :show, :id => "1"
  end

  it "should be successful" do
    do_get
    response.should be_success
  end
  
  it "should find the group requested" do
    Group.should_receive(:find).with("1").and_return(@group)
    do_get
  end
  
  it "should render the found group as xml" do
    @group.should_receive(:to_xml).and_return("XML")
    do_get
    response.body.should == "XML"
  end
end

describe GroupsController, "handling GET /groups/new" do

  before do
    @group = mock_model(Group)
    Group.stub!(:new).and_return(@group)
  end
  
  def do_get
    get :new
  end

  it "should be successful" do
    do_get
    response.should be_success
  end
  
  it "should render new template" do
    do_get
    response.should render_template('new')
  end
  
  it "should create an new group" do
    Group.should_receive(:new).and_return(@group)
    do_get
  end
  
  it "should not save the new group" do
    @group.should_not_receive(:save)
    do_get
  end
  
  it "should assign the new group for the view" do
    do_get
    assigns[:group].should equal(@group)
  end
end

describe GroupsController, "handling GET /groups/1/edit" do

  before do
    @group = mock_model(Group)
    Group.stub!(:find).and_return(@group)
  end
  
  def do_get
    get :edit, :id => "1"
  end

  it "should be successful" do
    do_get
    response.should be_success
  end
  
  it "should render edit template" do
    do_get
    response.should render_template('edit')
  end
  
  it "should find the group requested" do
    Group.should_receive(:find).and_return(@group)
    do_get
  end
  
  it "should assign the found group for the view" do
    do_get
    assigns[:group].should equal(@group)
  end
end

describe GroupsController, "handling POST /groups" do

  before do
    @group = mock_model(Group, :to_param => "1")
    Group.stub!(:new).and_return(@group)
  end
  
  def post_with_successful_save
    @group.should_receive(:save).and_return(true)
    post :create, :group => {}
  end
  
  def post_with_failed_save
    @group.should_receive(:save).and_return(false)
    post :create, :group => {}
  end
  
  it "should create a new group" do
    Group.should_receive(:new).with({}).and_return(@group)
    post_with_successful_save
  end

  it "should redirect to the new group on successful save" do
    post_with_successful_save
    response.should redirect_to(group_url("1"))
  end

  it "should re-render 'new' on failed save" do
    post_with_failed_save
    response.should render_template('new')
  end
end

describe GroupsController, "handling PUT /groups/1" do

  before do
    @group = mock_model(Group, :to_param => "1")
    Group.stub!(:find).and_return(@group)
  end
  
  def put_with_successful_update
    @group.should_receive(:update_attributes).and_return(true)
    put :update, :id => "1"
  end
  
  def put_with_failed_update
    @group.should_receive(:update_attributes).and_return(false)
    put :update, :id => "1"
  end
  
  it "should find the group requested" do
    Group.should_receive(:find).with("1").and_return(@group)
    put_with_successful_update
  end

  it "should update the found group" do
    put_with_successful_update
    assigns(:group).should equal(@group)
  end

  it "should assign the found group for the view" do
    put_with_successful_update
    assigns(:group).should equal(@group)
  end

  it "should redirect to the group on successful update" do
    put_with_successful_update
    response.should redirect_to(group_url("1"))
  end

  it "should re-render 'edit' on failed update" do
    put_with_failed_update
    response.should render_template('edit')
  end
end

describe GroupsController, "handling DELETE /group/1" do

  before do
    @group = mock_model(Group, :destroy => true)
    Group.stub!(:find).and_return(@group)
  end
  
  def do_delete
    delete :destroy, :id => "1"
  end

  it "should find the group requested" do
    Group.should_receive(:find).with("1").and_return(@group)
    do_delete
  end
  
  it "should call destroy on the found group" do
    @group.should_receive(:destroy)
    do_delete
  end
  
  it "should redirect to the groups list" do
    do_delete
    response.should redirect_to(groups_url)
  end
end
