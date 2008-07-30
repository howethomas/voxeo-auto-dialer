require File.dirname(__FILE__) + '/../spec_helper'

describe OptionsController, "#route_for" do

  it "should map { :controller => 'options', :action => 'index' } to /options" do
    route_for(:controller => "options", :action => "index").should == "/options"
  end
  
  it "should map { :controller => 'options', :action => 'new' } to /options/new" do
    route_for(:controller => "options", :action => "new").should == "/options/new"
  end
  
  it "should map { :controller => 'options', :action => 'show', :id => 1 } to /options/1" do
    route_for(:controller => "options", :action => "show", :id => 1).should == "/options/1"
  end
  
  it "should map { :controller => 'options', :action => 'edit', :id => 1 } to /options/1/edit" do
    route_for(:controller => "options", :action => "edit", :id => 1).should == "/options/1/edit"
  end
  
  it "should map { :controller => 'options', :action => 'update', :id => 1} to /options/1" do
    route_for(:controller => "options", :action => "update", :id => 1).should == "/options/1"
  end
  
  it "should map { :controller => 'options', :action => 'destroy', :id => 1} to /options/1" do
    route_for(:controller => "options", :action => "destroy", :id => 1).should == "/options/1"
  end
  
end

describe OptionsController, "handling GET /options" do

  before do
    @option = mock_model(Option)
    Option.stub!(:find).and_return([@option])
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
  
  it "should find all options" do
    Option.should_receive(:find).with(:all).and_return([@option])
    do_get
  end
  
  it "should assign the found options for the view" do
    do_get
    assigns[:options].should == [@option]
  end
end

describe OptionsController, "handling GET /options.xml" do

  before do
    @option = mock_model(Option, :to_xml => "XML")
    Option.stub!(:find).and_return(@option)
  end
  
  def do_get
    @request.env["HTTP_ACCEPT"] = "application/xml"
    get :index
  end
  
  it "should be successful" do
    do_get
    response.should be_success
  end

  it "should find all options" do
    Option.should_receive(:find).with(:all).and_return([@option])
    do_get
  end
  
  it "should render the found option as xml" do
    @option.should_receive(:to_xml).and_return("XML")
    do_get
    response.body.should == "XML"
  end
end

describe OptionsController, "handling GET /options/1" do

  before do
    @option = mock_model(Option)
    Option.stub!(:find).and_return(@option)
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
  
  it "should find the option requested" do
    Option.should_receive(:find).with("1").and_return(@option)
    do_get
  end
  
  it "should assign the found option for the view" do
    do_get
    assigns[:option].should equal(@option)
  end
end

describe OptionsController, "handling GET /options/1.xml" do

  before do
    @option = mock_model(Option, :to_xml => "XML")
    Option.stub!(:find).and_return(@option)
  end
  
  def do_get
    @request.env["HTTP_ACCEPT"] = "application/xml"
    get :show, :id => "1"
  end

  it "should be successful" do
    do_get
    response.should be_success
  end
  
  it "should find the option requested" do
    Option.should_receive(:find).with("1").and_return(@option)
    do_get
  end
  
  it "should render the found option as xml" do
    @option.should_receive(:to_xml).and_return("XML")
    do_get
    response.body.should == "XML"
  end
end

describe OptionsController, "handling GET /options/new" do

  before do
    @option = mock_model(Option)
    Option.stub!(:new).and_return(@option)
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
  
  it "should create an new option" do
    Option.should_receive(:new).and_return(@option)
    do_get
  end
  
  it "should not save the new option" do
    @option.should_not_receive(:save)
    do_get
  end
  
  it "should assign the new option for the view" do
    do_get
    assigns[:option].should equal(@option)
  end
end

describe OptionsController, "handling GET /options/1/edit" do

  before do
    @option = mock_model(Option)
    Option.stub!(:find).and_return(@option)
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
  
  it "should find the option requested" do
    Option.should_receive(:find).and_return(@option)
    do_get
  end
  
  it "should assign the found option for the view" do
    do_get
    assigns[:option].should equal(@option)
  end
end

describe OptionsController, "handling POST /options" do

  before do
    @option = mock_model(Option, :to_param => "1")
    Option.stub!(:new).and_return(@option)
  end
  
  def post_with_successful_save
    @option.should_receive(:save).and_return(true)
    post :create, :option => {}
  end
  
  def post_with_failed_save
    @option.should_receive(:save).and_return(false)
    post :create, :option => {}
  end
  
  it "should create a new option" do
    Option.should_receive(:new).with({}).and_return(@option)
    post_with_successful_save
  end

  it "should redirect to the new option on successful save" do
    post_with_successful_save
    response.should redirect_to(option_url("1"))
  end

  it "should re-render 'new' on failed save" do
    post_with_failed_save
    response.should render_template('new')
  end
end

describe OptionsController, "handling PUT /options/1" do

  before do
    @option = mock_model(Option, :to_param => "1")
    Option.stub!(:find).and_return(@option)
  end
  
  def put_with_successful_update
    @option.should_receive(:update_attributes).and_return(true)
    put :update, :id => "1"
  end
  
  def put_with_failed_update
    @option.should_receive(:update_attributes).and_return(false)
    put :update, :id => "1"
  end
  
  it "should find the option requested" do
    Option.should_receive(:find).with("1").and_return(@option)
    put_with_successful_update
  end

  it "should update the found option" do
    put_with_successful_update
    assigns(:option).should equal(@option)
  end

  it "should assign the found option for the view" do
    put_with_successful_update
    assigns(:option).should equal(@option)
  end

  it "should redirect to the option on successful update" do
    put_with_successful_update
    response.should redirect_to(option_url("1"))
  end

  it "should re-render 'edit' on failed update" do
    put_with_failed_update
    response.should render_template('edit')
  end
end

describe OptionsController, "handling DELETE /option/1" do

  before do
    @option = mock_model(Option, :destroy => true)
    Option.stub!(:find).and_return(@option)
  end
  
  def do_delete
    delete :destroy, :id => "1"
  end

  it "should find the option requested" do
    Option.should_receive(:find).with("1").and_return(@option)
    do_delete
  end
  
  it "should call destroy on the found option" do
    @option.should_receive(:destroy)
    do_delete
  end
  
  it "should redirect to the options list" do
    do_delete
    response.should redirect_to(options_url)
  end
end
