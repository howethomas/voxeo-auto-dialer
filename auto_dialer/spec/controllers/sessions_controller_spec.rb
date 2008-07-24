require File.dirname(__FILE__) + '/../spec_helper'

# Be sure to include AuthenticatedTestHelper in spec/spec_helper.rb instead
# Then, you can remove it from this and the units test.
include AuthenticatedTestHelper

describe SessionsController do
  fixtures :sessions

  it 'allows signup' do
    lambda do
      create_sessions
      response.should be_redirect
    end.should change(Sessions, :count).by(1)
  end

  

  

  it 'requires login on signup' do
    lambda do
      create_sessions(:login => nil)
      assigns[:sessions].errors.on(:login).should_not be_nil
      response.should be_success
    end.should_not change(Sessions, :count)
  end
  
  it 'requires password on signup' do
    lambda do
      create_sessions(:password => nil)
      assigns[:sessions].errors.on(:password).should_not be_nil
      response.should be_success
    end.should_not change(Sessions, :count)
  end
  
  it 'requires password confirmation on signup' do
    lambda do
      create_sessions(:password_confirmation => nil)
      assigns[:sessions].errors.on(:password_confirmation).should_not be_nil
      response.should be_success
    end.should_not change(Sessions, :count)
  end

  it 'requires email on signup' do
    lambda do
      create_sessions(:email => nil)
      assigns[:sessions].errors.on(:email).should_not be_nil
      response.should be_success
    end.should_not change(Sessions, :count)
  end
  
  
  
  def create_sessions(options = {})
    post :create, :sessions => { :login => 'quire', :email => 'quire@example.com',
      :password => 'quire', :password_confirmation => 'quire' }.merge(options)
  end
end