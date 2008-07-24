require File.dirname(__FILE__) + '/../spec_helper'

describe HistoriesController, "#route_for" do

  it "should map { :controller => 'histories', :action => 'index' } to /histories" do
    route_for(:controller => "histories", :action => "index").should == "/histories"
  end
  
  it "should map { :controller => 'histories', :action => 'new' } to /histories/new" do
    route_for(:controller => "histories", :action => "new").should == "/histories/new"
  end
  
  it "should map { :controller => 'histories', :action => 'show', :id => 1 } to /histories/1" do
    route_for(:controller => "histories", :action => "show", :id => 1).should == "/histories/1"
  end
  
  it "should map { :controller => 'histories', :action => 'edit', :id => 1 } to /histories/1/edit" do
    route_for(:controller => "histories", :action => "edit", :id => 1).should == "/histories/1/edit"
  end
  
  it "should map { :controller => 'histories', :action => 'update', :id => 1} to /histories/1" do
    route_for(:controller => "histories", :action => "update", :id => 1).should == "/histories/1"
  end
  
  it "should map { :controller => 'histories', :action => 'destroy', :id => 1} to /histories/1" do
    route_for(:controller => "histories", :action => "destroy", :id => 1).should == "/histories/1"
  end
  
end

describe HistoriesController, "handling GET /histories" do

  before do
    @history = mock_model(History)
    History.stub!(:find).and_return([@history])
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
  
  it "should find all histories" do
    History.should_receive(:find).with(:all).and_return([@history])
    do_get
  end
  
  it "should assign the found histories for the view" do
    do_get
    assigns[:histories].should == [@history]
  end
end

describe HistoriesController, "handling GET /histories.xml" do

  before do
    @history = mock_model(History, :to_xml => "XML")
    History.stub!(:find).and_return(@history)
  end
  
  def do_get
    @request.env["HTTP_ACCEPT"] = "application/xml"
    get :index
  end
  
  it "should be successful" do
    do_get
    response.should be_success
  end

  it "should find all histories" do
    History.should_receive(:find).with(:all).and_return([@history])
    do_get
  end
  
  it "should render the found history as xml" do
    @history.should_receive(:to_xml).and_return("XML")
    do_get
    response.body.should == "XML"
  end
end

describe HistoriesController, "handling GET /histories/1" do

  before do
    @history = mock_model(History)
    History.stub!(:find).and_return(@history)
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
  
  it "should find the history requested" do
    History.should_receive(:find).with("1").and_return(@history)
    do_get
  end
  
  it "should assign the found history for the view" do
    do_get
    assigns[:history].should equal(@history)
  end
end

describe HistoriesController, "handling GET /histories/1.xml" do

  before do
    @history = mock_model(History, :to_xml => "XML")
    History.stub!(:find).and_return(@history)
  end
  
  def do_get
    @request.env["HTTP_ACCEPT"] = "application/xml"
    get :show, :id => "1"
  end

  it "should be successful" do
    do_get
    response.should be_success
  end
  
  it "should find the history requested" do
    History.should_receive(:find).with("1").and_return(@history)
    do_get
  end
  
  it "should render the found history as xml" do
    @history.should_receive(:to_xml).and_return("XML")
    do_get
    response.body.should == "XML"
  end
end

describe HistoriesController, "handling GET /histories/new" do

  before do
    @history = mock_model(History)
    History.stub!(:new).and_return(@history)
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
  
  it "should create an new history" do
    History.should_receive(:new).and_return(@history)
    do_get
  end
  
  it "should not save the new history" do
    @history.should_not_receive(:save)
    do_get
  end
  
  it "should assign the new history for the view" do
    do_get
    assigns[:history].should equal(@history)
  end
end

describe HistoriesController, "handling GET /histories/1/edit" do

  before do
    @history = mock_model(History)
    History.stub!(:find).and_return(@history)
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
  
  it "should find the history requested" do
    History.should_receive(:find).and_return(@history)
    do_get
  end
  
  it "should assign the found history for the view" do
    do_get
    assigns[:history].should equal(@history)
  end
end

describe HistoriesController, "handling POST /histories" do

  before do
    @history = mock_model(History, :to_param => "1")
    History.stub!(:new).and_return(@history)
  end
  
  def post_with_successful_save
    @history.should_receive(:save).and_return(true)
    post :create, :history => {}
  end
  
  def post_with_failed_save
    @history.should_receive(:save).and_return(false)
    post :create, :history => {}
  end
  
  it "should create a new history" do
    History.should_receive(:new).with({}).and_return(@history)
    post_with_successful_save
  end

  it "should redirect to the new history on successful save" do
    post_with_successful_save
    response.should redirect_to(history_url("1"))
  end

  it "should re-render 'new' on failed save" do
    post_with_failed_save
    response.should render_template('new')
  end
end

describe HistoriesController, "handling PUT /histories/1" do

  before do
    @history = mock_model(History, :to_param => "1")
    History.stub!(:find).and_return(@history)
  end
  
  def put_with_successful_update
    @history.should_receive(:update_attributes).and_return(true)
    put :update, :id => "1"
  end
  
  def put_with_failed_update
    @history.should_receive(:update_attributes).and_return(false)
    put :update, :id => "1"
  end
  
  it "should find the history requested" do
    History.should_receive(:find).with("1").and_return(@history)
    put_with_successful_update
  end

  it "should update the found history" do
    put_with_successful_update
    assigns(:history).should equal(@history)
  end

  it "should assign the found history for the view" do
    put_with_successful_update
    assigns(:history).should equal(@history)
  end

  it "should redirect to the history on successful update" do
    put_with_successful_update
    response.should redirect_to(history_url("1"))
  end

  it "should re-render 'edit' on failed update" do
    put_with_failed_update
    response.should render_template('edit')
  end
end

describe HistoriesController, "handling DELETE /history/1" do

  before do
    @history = mock_model(History, :destroy => true)
    History.stub!(:find).and_return(@history)
  end
  
  def do_delete
    delete :destroy, :id => "1"
  end

  it "should find the history requested" do
    History.should_receive(:find).with("1").and_return(@history)
    do_delete
  end
  
  it "should call destroy on the found history" do
    @history.should_receive(:destroy)
    do_delete
  end
  
  it "should redirect to the histories list" do
    do_delete
    response.should redirect_to(histories_url)
  end
end
