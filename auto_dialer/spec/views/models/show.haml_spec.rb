require File.dirname(__FILE__) + '/../../spec_helper'

describe "/Models/show.haml" do
  include ModelsHelper
  
  before do
    @model = mock_model(Model)
    @model.stub!(:test).and_return("MyString")
    @model.stub!(:test2).and_return("1")

    assigns[:model] = @model
  end

  it "should render attributes in <p>" do
    render "/Models/show.haml"
    response.should have_text(/MyString/)
    response.should have_text(/1/)
  end
end

