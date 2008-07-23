require File.dirname(__FILE__) + '/../../spec_helper'

describe "/Models/index.haml" do
  include ModelsHelper
  
  before do
    model_98 = mock_model(Model)
    model_98.should_receive(:test).and_return("MyString")
    model_98.should_receive(:test2).and_return("1")
    model_99 = mock_model(Model)
    model_99.should_receive(:test).and_return("MyString")
    model_99.should_receive(:test2).and_return("1")

    assigns[:models] = [model_98, model_99]
  end

  it "should render list of models" do
    render "/Models/index.haml"
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "1", 2)
  end
end
