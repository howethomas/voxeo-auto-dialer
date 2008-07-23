require File.dirname(__FILE__) + '/../spec_helper'

describe ModelsController, "#route_for" do

  it "should map { :controller => 'Models', :action => 'index' } to /Models" do
    route_for(:controller => "Models", :action => "index").should == "/Models"
  end
  
  it "should map { :controller => 'Models', :action => 'new' } to /Models/new" do
    route_for(:controller => "Models", :action => "new").should == "/Models/new"
  end
  
  it "should map { :controller => 'Models', :action => 'show', :id => 1 } to /Models/1" do
    route_for(:controller => "Models", :action => "show", :id => 1).should == "/Models/1"
  end
  
  it "should map { :controller => 'Models', :action => 'edit', :id => 1 } to /Models/1/edit" do
    route_for(:controller => "Models", :action => "edit", :id => 1).should == "/Models/1/edit"
  end
  
  it "should map { :controller => 'Models', :action => 'update', :id => 1} to /Models/1" do
    route_for(:controller => "Models", :action => "update", :id => 1).should == "/Models/1"
  end
  
  it "should map { :controller => 'Models', :action => 'destroy', :id => 1} to /Models/1" do
    route_for(:controller => "Models", :action => "destroy", :id => 1).should == "/Models/1"
  end
  
end

describe ModelsController, "handling GET /Models" do

  before do
    @model = mock_model(Model)
    Model.stub!(:find).and_return([@model])
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
  
  it "should find all Models" do
    Model.should_receive(:find).with(:all).and_return([@model])
    do_get
  end
  
  it "should assign the found Models for the view" do
    do_get
    assigns[:models].should == [@model]
  end
end

describe ModelsController, "handling GET /Models.xml" do

  before do
    @model = mock_model(Model, :to_xml => "XML")
    Model.stub!(:find).and_return(@model)
  end
  
  def do_get
    @request.env["HTTP_ACCEPT"] = "application/xml"
    get :index
  end
  
  it "should be successful" do
    do_get
    response.should be_success
  end

  it "should find all Models" do
    Model.should_receive(:find).with(:all).and_return([@model])
    do_get
  end
  
  it "should render the found Model as xml" do
    @model.should_receive(:to_xml).and_return("XML")
    do_get
    response.body.should == "XML"
  end
end

describe ModelsController, "handling GET /Models/1" do

  before do
    @model = mock_model(Model)
    Model.stub!(:find).and_return(@model)
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
  
  it "should find the model requested" do
    Model.should_receive(:find).with("1").and_return(@model)
    do_get
  end
  
  it "should assign the found model for the view" do
    do_get
    assigns[:model].should equal(@model)
  end
end

describe ModelsController, "handling GET /Models/1.xml" do

  before do
    @model = mock_model(Model, :to_xml => "XML")
    Model.stub!(:find).and_return(@model)
  end
  
  def do_get
    @request.env["HTTP_ACCEPT"] = "application/xml"
    get :show, :id => "1"
  end

  it "should be successful" do
    do_get
    response.should be_success
  end
  
  it "should find the model requested" do
    Model.should_receive(:find).with("1").and_return(@model)
    do_get
  end
  
  it "should render the found model as xml" do
    @model.should_receive(:to_xml).and_return("XML")
    do_get
    response.body.should == "XML"
  end
end

describe ModelsController, "handling GET /Models/new" do

  before do
    @model = mock_model(Model)
    Model.stub!(:new).and_return(@model)
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
  
  it "should create an new model" do
    Model.should_receive(:new).and_return(@model)
    do_get
  end
  
  it "should not save the new model" do
    @model.should_not_receive(:save)
    do_get
  end
  
  it "should assign the new model for the view" do
    do_get
    assigns[:model].should equal(@model)
  end
end

describe ModelsController, "handling GET /Models/1/edit" do

  before do
    @model = mock_model(Model)
    Model.stub!(:find).and_return(@model)
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
  
  it "should find the model requested" do
    Model.should_receive(:find).and_return(@model)
    do_get
  end
  
  it "should assign the found model for the view" do
    do_get
    assigns[:model].should equal(@model)
  end
end

describe ModelsController, "handling POST /Models" do

  before do
    @model = mock_model(Model, :to_param => "1")
    Model.stub!(:new).and_return(@model)
  end
  
  def post_with_successful_save
    @model.should_receive(:save).and_return(true)
    post :create, :model => {}
  end
  
  def post_with_failed_save
    @model.should_receive(:save).and_return(false)
    post :create, :model => {}
  end
  
  it "should create a new model" do
    Model.should_receive(:new).with({}).and_return(@model)
    post_with_successful_save
  end

  it "should redirect to the new model on successful save" do
    post_with_successful_save
    response.should redirect_to(model_url("1"))
  end

  it "should re-render 'new' on failed save" do
    post_with_failed_save
    response.should render_template('new')
  end
end

describe ModelsController, "handling PUT /Models/1" do

  before do
    @model = mock_model(Model, :to_param => "1")
    Model.stub!(:find).and_return(@model)
  end
  
  def put_with_successful_update
    @model.should_receive(:update_attributes).and_return(true)
    put :update, :id => "1"
  end
  
  def put_with_failed_update
    @model.should_receive(:update_attributes).and_return(false)
    put :update, :id => "1"
  end
  
  it "should find the model requested" do
    Model.should_receive(:find).with("1").and_return(@model)
    put_with_successful_update
  end

  it "should update the found model" do
    put_with_successful_update
    assigns(:model).should equal(@model)
  end

  it "should assign the found model for the view" do
    put_with_successful_update
    assigns(:model).should equal(@model)
  end

  it "should redirect to the model on successful update" do
    put_with_successful_update
    response.should redirect_to(model_url("1"))
  end

  it "should re-render 'edit' on failed update" do
    put_with_failed_update
    response.should render_template('edit')
  end
end

describe ModelsController, "handling DELETE /Model/1" do

  before do
    @model = mock_model(Model, :destroy => true)
    Model.stub!(:find).and_return(@model)
  end
  
  def do_delete
    delete :destroy, :id => "1"
  end

  it "should find the model requested" do
    Model.should_receive(:find).with("1").and_return(@model)
    do_delete
  end
  
  it "should call destroy on the found model" do
    @model.should_receive(:destroy)
    do_delete
  end
  
  it "should redirect to the Models list" do
    do_delete
    response.should redirect_to(models_url)
  end
end
