require File.dirname(__FILE__) + '/../spec_helper'

describe SchedulesController, "#route_for" do

  it "should map { :controller => 'schedules', :action => 'index' } to /schedules" do
    route_for(:controller => "schedules", :action => "index").should == "/schedules"
  end
  
  it "should map { :controller => 'schedules', :action => 'new' } to /schedules/new" do
    route_for(:controller => "schedules", :action => "new").should == "/schedules/new"
  end
  
  it "should map { :controller => 'schedules', :action => 'show', :id => 1 } to /schedules/1" do
    route_for(:controller => "schedules", :action => "show", :id => 1).should == "/schedules/1"
  end
  
  it "should map { :controller => 'schedules', :action => 'edit', :id => 1 } to /schedules/1/edit" do
    route_for(:controller => "schedules", :action => "edit", :id => 1).should == "/schedules/1/edit"
  end
  
  it "should map { :controller => 'schedules', :action => 'update', :id => 1} to /schedules/1" do
    route_for(:controller => "schedules", :action => "update", :id => 1).should == "/schedules/1"
  end
  
  it "should map { :controller => 'schedules', :action => 'destroy', :id => 1} to /schedules/1" do
    route_for(:controller => "schedules", :action => "destroy", :id => 1).should == "/schedules/1"
  end
  
end

describe SchedulesController, "handling GET /schedules" do

  before do
    @schedule = mock_model(Schedule)
    Schedule.stub!(:find).and_return([@schedule])
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
  
  it "should find all schedules" do
    Schedule.should_receive(:find).with(:all).and_return([@schedule])
    do_get
  end
  
  it "should assign the found schedules for the view" do
    do_get
    assigns[:schedules].should == [@schedule]
  end
end

describe SchedulesController, "handling GET /schedules.xml" do

  before do
    @schedule = mock_model(Schedule, :to_xml => "XML")
    Schedule.stub!(:find).and_return(@schedule)
  end
  
  def do_get
    @request.env["HTTP_ACCEPT"] = "application/xml"
    get :index
  end
  
  it "should be successful" do
    do_get
    response.should be_success
  end

  it "should find all schedules" do
    Schedule.should_receive(:find).with(:all).and_return([@schedule])
    do_get
  end
  
  it "should render the found schedule as xml" do
    @schedule.should_receive(:to_xml).and_return("XML")
    do_get
    response.body.should == "XML"
  end
end

describe SchedulesController, "handling GET /schedules/1" do

  before do
    @schedule = mock_model(Schedule)
    Schedule.stub!(:find).and_return(@schedule)
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
  
  it "should find the schedule requested" do
    Schedule.should_receive(:find).with("1").and_return(@schedule)
    do_get
  end
  
  it "should assign the found schedule for the view" do
    do_get
    assigns[:schedule].should equal(@schedule)
  end
end

describe SchedulesController, "handling GET /schedules/1.xml" do

  before do
    @schedule = mock_model(Schedule, :to_xml => "XML")
    Schedule.stub!(:find).and_return(@schedule)
  end
  
  def do_get
    @request.env["HTTP_ACCEPT"] = "application/xml"
    get :show, :id => "1"
  end

  it "should be successful" do
    do_get
    response.should be_success
  end
  
  it "should find the schedule requested" do
    Schedule.should_receive(:find).with("1").and_return(@schedule)
    do_get
  end
  
  it "should render the found schedule as xml" do
    @schedule.should_receive(:to_xml).and_return("XML")
    do_get
    response.body.should == "XML"
  end
end

describe SchedulesController, "handling GET /schedules/new" do

  before do
    @schedule = mock_model(Schedule)
    Schedule.stub!(:new).and_return(@schedule)
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
  
  it "should create an new schedule" do
    Schedule.should_receive(:new).and_return(@schedule)
    do_get
  end
  
  it "should not save the new schedule" do
    @schedule.should_not_receive(:save)
    do_get
  end
  
  it "should assign the new schedule for the view" do
    do_get
    assigns[:schedule].should equal(@schedule)
  end
end

describe SchedulesController, "handling GET /schedules/1/edit" do

  before do
    @schedule = mock_model(Schedule)
    Schedule.stub!(:find).and_return(@schedule)
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
  
  it "should find the schedule requested" do
    Schedule.should_receive(:find).and_return(@schedule)
    do_get
  end
  
  it "should assign the found schedule for the view" do
    do_get
    assigns[:schedule].should equal(@schedule)
  end
end

describe SchedulesController, "handling POST /schedules" do

  before do
    @schedule = mock_model(Schedule, :to_param => "1")
    Schedule.stub!(:new).and_return(@schedule)
  end
  
  def post_with_successful_save
    @schedule.should_receive(:save).and_return(true)
    post :create, :schedule => {}
  end
  
  def post_with_failed_save
    @schedule.should_receive(:save).and_return(false)
    post :create, :schedule => {}
  end
  
  it "should create a new schedule" do
    Schedule.should_receive(:new).with({}).and_return(@schedule)
    post_with_successful_save
  end

  it "should redirect to the new schedule on successful save" do
    post_with_successful_save
    response.should redirect_to(schedule_url("1"))
  end

  it "should re-render 'new' on failed save" do
    post_with_failed_save
    response.should render_template('new')
  end
end

describe SchedulesController, "handling PUT /schedules/1" do

  before do
    @schedule = mock_model(Schedule, :to_param => "1")
    Schedule.stub!(:find).and_return(@schedule)
  end
  
  def put_with_successful_update
    @schedule.should_receive(:update_attributes).and_return(true)
    put :update, :id => "1"
  end
  
  def put_with_failed_update
    @schedule.should_receive(:update_attributes).and_return(false)
    put :update, :id => "1"
  end
  
  it "should find the schedule requested" do
    Schedule.should_receive(:find).with("1").and_return(@schedule)
    put_with_successful_update
  end

  it "should update the found schedule" do
    put_with_successful_update
    assigns(:schedule).should equal(@schedule)
  end

  it "should assign the found schedule for the view" do
    put_with_successful_update
    assigns(:schedule).should equal(@schedule)
  end

  it "should redirect to the schedule on successful update" do
    put_with_successful_update
    response.should redirect_to(schedule_url("1"))
  end

  it "should re-render 'edit' on failed update" do
    put_with_failed_update
    response.should render_template('edit')
  end
end

describe SchedulesController, "handling DELETE /schedule/1" do

  before do
    @schedule = mock_model(Schedule, :destroy => true)
    Schedule.stub!(:find).and_return(@schedule)
  end
  
  def do_delete
    delete :destroy, :id => "1"
  end

  it "should find the schedule requested" do
    Schedule.should_receive(:find).with("1").and_return(@schedule)
    do_delete
  end
  
  it "should call destroy on the found schedule" do
    @schedule.should_receive(:destroy)
    do_delete
  end
  
  it "should redirect to the schedules list" do
    do_delete
    response.should redirect_to(schedules_url)
  end
end
