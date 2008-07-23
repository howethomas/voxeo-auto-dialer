require File.dirname(__FILE__) + '/../../spec_helper'

describe "/Model/edit.haml" do
  include ModelsHelper
  
  before do
    @model = mock_model(Model)
    @model.stub!(:test).and_return("MyString")
    @model.stub!(:test2).and_return("1")
    assigns[:model] = @model
  end

  it "should render edit form" do
    render "/Models/edit.haml"
    
    response.should have_tag("form[action=#{model_path(@model)}][method=post]") do
      with_tag('input#model_test[name=?]', "model[test]")
      with_tag('input#model_test2[name=?]', "model[test2]")
    end
  end
end