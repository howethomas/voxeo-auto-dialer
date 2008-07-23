require File.dirname(__FILE__) + '/../../spec_helper'

describe "/Models/new.haml" do
  include ModelsHelper
  
  before do
    @model = mock_model(Model)
    @model.stub!(:new_record?).and_return(true)
    @model.stub!(:test).and_return("MyString")
    @model.stub!(:test2).and_return("1")
    assigns[:model] = @model
  end

  it "should render new form" do
    render "/Models/new.haml"
    
    response.should have_tag("form[action=?][method=post]", models_path) do
      with_tag("input#model_test[name=?]", "model[test]")
      with_tag("input#model_test2[name=?]", "model[test2]")
    end
  end
end
