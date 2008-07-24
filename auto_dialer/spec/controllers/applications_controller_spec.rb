require File.dirname(__FILE__) + '/../spec_helper'

describe ApplicationsController, "#route_for" do

  it "should map { :controller => 'applications', :action => 'index' } to /applications" do
    route_for(:controller => "applications", :action => "index").should == "/applications"
  end
  
  it "should map { :controller => 'applications', :action => 'new' } to /applications/new" do
    route_for(:controller => "applications", :action => "new").should == "/applications/new"
  end
  
  it "should map { :controller => 'applications', :action => 'show', :id => 1 } to /applications/1" do
    route_for(:controller => "applications", :action => "show", :id => 1).should == "/applications/1"
  end
  
  it "should map { :controller => 'applications', :action => 'edit', :id => 1 } to /applications/1/edit" do
    route_for(:controller => "applications", :action => "edit", :id => 1).should == "/applications/1/edit"
  end
  
  it "should map { :controller => 'applications', :action => 'update', :id => 1} to /applications/1" do
    route_for(:controller => "applications", :action => "update", :id => 1).should == "/applications/1"
  end
  
  it "should map { :controller => 'applications', :action => 'destroy', :id => 1} to /applications/1" do
    route_for(:controller => "applications", :action => "destroy", :id => 1).should == "/applications/1"
  end
  
end

describe ApplicationsController, "handling GET /applications" do

  before do
    @application = mock_model(Application)
    Application.stub!(:find).and_return([@application])
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
  
  it "should find all applications" do
    Application.should_receive(:find).with(:all).and_return([@application])
    do_get
  end
  
  it "should assign the found applications for the view" do
    do_get
    assigns[:applications].should == [@application]
  end
end

describe ApplicationsController, "handling GET /applications.xml" do

  before do
    @application = mock_model(Application, :to_xml => "XML")
    Application.stub!(:find).and_return(@application)
  end
  
  def do_get
    @request.env["HTTP_ACCEPT"] = "application/xml"
    get :index
  end
  
  it "should be successful" do
    do_get
    response.should be_success
  end

  it "should find all applications" do
    Application.should_receive(:find).with(:all).and_return([@application])
    do_get
  end
  
  it "should render the found application as xml" do
    @application.should_receive(:to_xml).and_return("XML")
    do_get
    response.body.should == "XML"
  end
end

describe ApplicationsController, "handling GET /applications/1" do

  before do
    @application = mock_model(Application)
    Application.stub!(:find).and_return(@application)
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
  
  it "should find the application requested" do
    Application.should_receive(:find).with("1").and_return(@application)
    do_get
  end
  
  it "should assign the found application for the view" do
    do_get
    assigns[:application].should equal(@application)
  end
end

describe ApplicationsController, "handling GET /applications/1.xml" do

  before do
    @application = mock_model(Application, :to_xml => "XML")
    Application.stub!(:find).and_return(@application)
  end
  
  def do_get
    @request.env["HTTP_ACCEPT"] = "application/xml"
    get :show, :id => "1"
  end

  it "should be successful" do
    do_get
    response.should be_success
  end
  
  it "should find the application requested" do
    Application.should_receive(:find).with("1").and_return(@application)
    do_get
  end
  
  it "should render the found application as xml" do
    @application.should_receive(:to_xml).and_return("XML")
    do_get
    response.body.should == "XML"
  end
end

describe ApplicationsController, "handling GET /applications/new" do

  before do
    @application = mock_model(Application)
    Application.stub!(:new).and_return(@application)
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
  
  it "should create an new application" do
    Application.should_receive(:new).and_return(@application)
    do_get
  end
  
  it "should not save the new application" do
    @application.should_not_receive(:save)
    do_get
  end
  
  it "should assign the new application for the view" do
    do_get
    assigns[:application].should equal(@application)
  end
end

describe ApplicationsController, "handling GET /applications/1/edit" do

  before do
    @application = mock_model(Application)
    Application.stub!(:find).and_return(@application)
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
  
  it "should find the application requested" do
    Application.should_receive(:find).and_return(@application)
    do_get
  end
  
  it "should assign the found application for the view" do
    do_get
    assigns[:application].should equal(@application)
  end
end

describe ApplicationsController, "handling POST /applications" do

  before do
    @application = mock_model(Application, :to_param => "1")
    Application.stub!(:new).and_return(@application)
  end
  
  def post_with_successful_save
    @application.should_receive(:save).and_return(true)
    post :create, :application => {}
  end
  
  def post_with_failed_save
    @application.should_receive(:save).and_return(false)
    post :create, :application => {}
  end
  
  it "should create a new application" do
    Application.should_receive(:new).with({}).and_return(@application)
    post_with_successful_save
  end

  it "should redirect to the new application on successful save" do
    post_with_successful_save
    response.should redirect_to(application_url("1"))
  end

  it "should re-render 'new' on failed save" do
    post_with_failed_save
    response.should render_template('new')
  end
end

describe ApplicationsController, "handling PUT /applications/1" do

  before do
    @application = mock_model(Application, :to_param => "1")
    Application.stub!(:find).and_return(@application)
  end
  
  def put_with_successful_update
    @application.should_receive(:update_attributes).and_return(true)
    put :update, :id => "1"
  end
  
  def put_with_failed_update
    @application.should_receive(:update_attributes).and_return(false)
    put :update, :id => "1"
  end
  
  it "should find the application requested" do
    Application.should_receive(:find).with("1").and_return(@application)
    put_with_successful_update
  end

  it "should update the found application" do
    put_with_successful_update
    assigns(:application).should equal(@application)
  end

  it "should assign the found application for the view" do
    put_with_successful_update
    assigns(:application).should equal(@application)
  end

  it "should redirect to the application on successful update" do
    put_with_successful_update
    response.should redirect_to(application_url("1"))
  end

  it "should re-render 'edit' on failed update" do
    put_with_failed_update
    response.should render_template('edit')
  end
end

describe ApplicationsController, "handling DELETE /application/1" do

  before do
    @application = mock_model(Application, :destroy => true)
    Application.stub!(:find).and_return(@application)
  end
  
  def do_delete
    delete :destroy, :id => "1"
  end

  it "should find the application requested" do
    Application.should_receive(:find).with("1").and_return(@application)
    do_delete
  end
  
  it "should call destroy on the found application" do
    @application.should_receive(:destroy)
    do_delete
  end
  
  it "should redirect to the applications list" do
    do_delete
    response.should redirect_to(applications_url)
  end
end
