require File.dirname(__FILE__) + '/../test_helper'

class App < ActiveSupport::TestCase
  def test_should_have_unique_name
    
    
  end
  def create(options={})
    App.create(@@app_default_values.merge(options))
  end
  
end
