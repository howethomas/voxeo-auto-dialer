require File.dirname(__FILE__) + '/../spec_helper'

describe ContactsController, "#route_for" do

  it "should map { :controller => 'contacts', :action => 'index' } to /contacts" do
    route_for(:controller => "contacts", :action => "index").should == "/contacts"
  end
  
  it "should map { :controller => 'contacts', :action => 'new' } to /contacts/new" do
    route_for(:controller => "contacts", :action => "new").should == "/contacts/new"
  end
  
  it "should map { :controller => 'contacts', :action => 'show', :id => 1 } to /contacts/1" do
    route_for(:controller => "contacts", :action => "show", :id => 1).should == "/contacts/1"
  end
  
  it "should map { :controller => 'contacts', :action => 'edit', :id => 1 } to /contacts/1/edit" do
    route_for(:controller => "contacts", :action => "edit", :id => 1).should == "/contacts/1/edit"
  end
  
  it "should map { :controller => 'contacts', :action => 'update', :id => 1} to /contacts/1" do
    route_for(:controller => "contacts", :action => "update", :id => 1).should == "/contacts/1"
  end
  
  it "should map { :controller => 'contacts', :action => 'destroy', :id => 1} to /contacts/1" do
    route_for(:controller => "contacts", :action => "destroy", :id => 1).should == "/contacts/1"
  end
  
end

describe ContactsController, "handling GET /contacts" do

  before do
    @contact = mock_model(Contact)
    Contact.stub!(:find).and_return([@contact])
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
  
  it "should find all contacts" do
    Contact.should_receive(:find).with(:all).and_return([@contact])
    do_get
  end
  
  it "should assign the found contacts for the view" do
    do_get
    assigns[:contacts].should == [@contact]
  end
end

describe ContactsController, "handling GET /contacts.xml" do

  before do
    @contact = mock_model(Contact, :to_xml => "XML")
    Contact.stub!(:find).and_return(@contact)
  end
  
  def do_get
    @request.env["HTTP_ACCEPT"] = "application/xml"
    get :index
  end
  
  it "should be successful" do
    do_get
    response.should be_success
  end

  it "should find all contacts" do
    Contact.should_receive(:find).with(:all).and_return([@contact])
    do_get
  end
  
  it "should render the found contact as xml" do
    @contact.should_receive(:to_xml).and_return("XML")
    do_get
    response.body.should == "XML"
  end
end

describe ContactsController, "handling GET /contacts/1" do

  before do
    @contact = mock_model(Contact)
    Contact.stub!(:find).and_return(@contact)
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
  
  it "should find the contact requested" do
    Contact.should_receive(:find).with("1").and_return(@contact)
    do_get
  end
  
  it "should assign the found contact for the view" do
    do_get
    assigns[:contact].should equal(@contact)
  end
end

describe ContactsController, "handling GET /contacts/1.xml" do

  before do
    @contact = mock_model(Contact, :to_xml => "XML")
    Contact.stub!(:find).and_return(@contact)
  end
  
  def do_get
    @request.env["HTTP_ACCEPT"] = "application/xml"
    get :show, :id => "1"
  end

  it "should be successful" do
    do_get
    response.should be_success
  end
  
  it "should find the contact requested" do
    Contact.should_receive(:find).with("1").and_return(@contact)
    do_get
  end
  
  it "should render the found contact as xml" do
    @contact.should_receive(:to_xml).and_return("XML")
    do_get
    response.body.should == "XML"
  end
end

describe ContactsController, "handling GET /contacts/new" do

  before do
    @contact = mock_model(Contact)
    Contact.stub!(:new).and_return(@contact)
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
  
  it "should create an new contact" do
    Contact.should_receive(:new).and_return(@contact)
    do_get
  end
  
  it "should not save the new contact" do
    @contact.should_not_receive(:save)
    do_get
  end
  
  it "should assign the new contact for the view" do
    do_get
    assigns[:contact].should equal(@contact)
  end
end

describe ContactsController, "handling GET /contacts/1/edit" do

  before do
    @contact = mock_model(Contact)
    Contact.stub!(:find).and_return(@contact)
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
  
  it "should find the contact requested" do
    Contact.should_receive(:find).and_return(@contact)
    do_get
  end
  
  it "should assign the found contact for the view" do
    do_get
    assigns[:contact].should equal(@contact)
  end
end

describe ContactsController, "handling POST /contacts" do

  before do
    @contact = mock_model(Contact, :to_param => "1")
    Contact.stub!(:new).and_return(@contact)
  end
  
  def post_with_successful_save
    @contact.should_receive(:save).and_return(true)
    post :create, :contact => {}
  end
  
  def post_with_failed_save
    @contact.should_receive(:save).and_return(false)
    post :create, :contact => {}
  end
  
  it "should create a new contact" do
    Contact.should_receive(:new).with({}).and_return(@contact)
    post_with_successful_save
  end

  it "should redirect to the new contact on successful save" do
    post_with_successful_save
    response.should redirect_to(contact_url("1"))
  end

  it "should re-render 'new' on failed save" do
    post_with_failed_save
    response.should render_template('new')
  end
end

describe ContactsController, "handling PUT /contacts/1" do

  before do
    @contact = mock_model(Contact, :to_param => "1")
    Contact.stub!(:find).and_return(@contact)
  end
  
  def put_with_successful_update
    @contact.should_receive(:update_attributes).and_return(true)
    put :update, :id => "1"
  end
  
  def put_with_failed_update
    @contact.should_receive(:update_attributes).and_return(false)
    put :update, :id => "1"
  end
  
  it "should find the contact requested" do
    Contact.should_receive(:find).with("1").and_return(@contact)
    put_with_successful_update
  end

  it "should update the found contact" do
    put_with_successful_update
    assigns(:contact).should equal(@contact)
  end

  it "should assign the found contact for the view" do
    put_with_successful_update
    assigns(:contact).should equal(@contact)
  end

  it "should redirect to the contact on successful update" do
    put_with_successful_update
    response.should redirect_to(contact_url("1"))
  end

  it "should re-render 'edit' on failed update" do
    put_with_failed_update
    response.should render_template('edit')
  end
end

describe ContactsController, "handling DELETE /contact/1" do

  before do
    @contact = mock_model(Contact, :destroy => true)
    Contact.stub!(:find).and_return(@contact)
  end
  
  def do_delete
    delete :destroy, :id => "1"
  end

  it "should find the contact requested" do
    Contact.should_receive(:find).with("1").and_return(@contact)
    do_delete
  end
  
  it "should call destroy on the found contact" do
    @contact.should_receive(:destroy)
    do_delete
  end
  
  it "should redirect to the contacts list" do
    do_delete
    response.should redirect_to(contacts_url)
  end
end
