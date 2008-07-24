require File.dirname(__FILE__) + '/../spec_helper'

describe AppsController, "#route_for" do

  it "should map { :controller => 'apps', :action => 'index' } to /apps" do
    route_for(:controller => "apps", :action => "index").should == "/apps"
  end
  
  it "should map { :controller => 'apps', :action => 'new' } to /apps/new" do
    route_for(:controller => "apps", :action => "new").should == "/apps/new"
  end
  
  it "should map { :controller => 'apps', :action => 'show', :id => 1 } to /apps/1" do
    route_for(:controller => "apps", :action => "show", :id => 1).should == "/apps/1"
  end
  
  it "should map { :controller => 'apps', :action => 'edit', :id => 1 } to /apps/1/edit" do
    route_for(:controller => "apps", :action => "edit", :id => 1).should == "/apps/1/edit"
  end
  
  it "should map { :controller => 'apps', :action => 'update', :id => 1} to /apps/1" do
    route_for(:controller => "apps", :action => "update", :id => 1).should == "/apps/1"
  end
  
  it "should map { :controller => 'apps', :action => 'destroy', :id => 1} to /apps/1" do
    route_for(:controller => "apps", :action => "destroy", :id => 1).should == "/apps/1"
  end
  
end

describe AppsController, "handling GET /apps" do

  before do
    @app = mock_model(App)
    App.stub!(:find).and_return([@app])
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
  
  it "should find all apps" do
    App.should_receive(:find).with(:all).and_return([@app])
    do_get
  end
  
  it "should assign the found apps for the view" do
    do_get
    assigns[:apps].should == [@app]
  end
end

describe AppsController, "handling GET /apps.xml" do

  before do
    @app = mock_model(App, :to_xml => "XML")
    App.stub!(:find).and_return(@app)
  end
  
  def do_get
    @request.env["HTTP_ACCEPT"] = "application/xml"
    get :index
  end
  
  it "should be successful" do
    do_get
    response.should be_success
  end

  it "should find all apps" do
    App.should_receive(:find).with(:all).and_return([@app])
    do_get
  end
  
  it "should render the found app as xml" do
    @app.should_receive(:to_xml).and_return("XML")
    do_get
    response.body.should == "XML"
  end
end

describe AppsController, "handling GET /apps/1" do

  before do
    @app = mock_model(App)
    App.stub!(:find).and_return(@app)
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
  
  it "should find the app requested" do
    App.should_receive(:find).with("1").and_return(@app)
    do_get
  end
  
  it "should assign the found app for the view" do
    do_get
    assigns[:app].should equal(@app)
  end
end

describe AppsController, "handling GET /apps/1.xml" do

  before do
    @app = mock_model(App, :to_xml => "XML")
    App.stub!(:find).and_return(@app)
  end
  
  def do_get
    @request.env["HTTP_ACCEPT"] = "application/xml"
    get :show, :id => "1"
  end

  it "should be successful" do
    do_get
    response.should be_success
  end
  
  it "should find the app requested" do
    App.should_receive(:find).with("1").and_return(@app)
    do_get
  end
  
  it "should render the found app as xml" do
    @app.should_receive(:to_xml).and_return("XML")
    do_get
    response.body.should == "XML"
  end
end

describe AppsController, "handling GET /apps/new" do

  before do
    @app = mock_model(App)
    App.stub!(:new).and_return(@app)
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
  
  it "should create an new app" do
    App.should_receive(:new).and_return(@app)
    do_get
  end
  
  it "should not save the new app" do
    @app.should_not_receive(:save)
    do_get
  end
  
  it "should assign the new app for the view" do
    do_get
    assigns[:app].should equal(@app)
  end
end

describe AppsController, "handling GET /apps/1/edit" do

  before do
    @app = mock_model(App)
    App.stub!(:find).and_return(@app)
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
  
  it "should find the app requested" do
    App.should_receive(:find).and_return(@app)
    do_get
  end
  
  it "should assign the found app for the view" do
    do_get
    assigns[:app].should equal(@app)
  end
end

describe AppsController, "handling POST /apps" do

  before do
    @app = mock_model(App, :to_param => "1")
    App.stub!(:new).and_return(@app)
  end
  
  def post_with_successful_save
    @app.should_receive(:save).and_return(true)
    post :create, :app => {}
  end
  
  def post_with_failed_save
    @app.should_receive(:save).and_return(false)
    post :create, :app => {}
  end
  
  it "should create a new app" do
    App.should_receive(:new).with({}).and_return(@app)
    post_with_successful_save
  end

  it "should redirect to the new app on successful save" do
    post_with_successful_save
    response.should redirect_to(app_url("1"))
  end

  it "should re-render 'new' on failed save" do
    post_with_failed_save
    response.should render_template('new')
  end
end

describe AppsController, "handling PUT /apps/1" do

  before do
    @app = mock_model(App, :to_param => "1")
    App.stub!(:find).and_return(@app)
  end
  
  def put_with_successful_update
    @app.should_receive(:update_attributes).and_return(true)
    put :update, :id => "1"
  end
  
  def put_with_failed_update
    @app.should_receive(:update_attributes).and_return(false)
    put :update, :id => "1"
  end
  
  it "should find the app requested" do
    App.should_receive(:find).with("1").and_return(@app)
    put_with_successful_update
  end

  it "should update the found app" do
    put_with_successful_update
    assigns(:app).should equal(@app)
  end

  it "should assign the found app for the view" do
    put_with_successful_update
    assigns(:app).should equal(@app)
  end

  it "should redirect to the app on successful update" do
    put_with_successful_update
    response.should redirect_to(app_url("1"))
  end

  it "should re-render 'edit' on failed update" do
    put_with_failed_update
    response.should render_template('edit')
  end
end

describe AppsController, "handling DELETE /app/1" do

  before do
    @app = mock_model(App, :destroy => true)
    App.stub!(:find).and_return(@app)
  end
  
  def do_delete
    delete :destroy, :id => "1"
  end

  it "should find the app requested" do
    App.should_receive(:find).with("1").and_return(@app)
    do_delete
  end
  
  it "should call destroy on the found app" do
    @app.should_receive(:destroy)
    do_delete
  end
  
  it "should redirect to the apps list" do
    do_delete
    response.should redirect_to(apps_url)
  end
end
