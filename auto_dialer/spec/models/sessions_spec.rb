require File.dirname(__FILE__) + '/../spec_helper'

# Be sure to include AuthenticatedTestHelper in spec/spec_helper.rb instead.
# Then, you can remove it from this and the functional test.
include AuthenticatedTestHelper

describe Sessions do
  fixtures :sessions

  describe 'being created' do
    before do
      @sessions = nil
      @creating_sessions = lambda do
        @sessions = create_sessions
        violated "#{@sessions.errors.full_messages.to_sentence}" if @sessions.new_record?
      end
    end
    
    it 'increments User#count' do
      @creating_sessions.should change(Sessions, :count).by(1)
    end
  end

  it 'requires login' do
    lambda do
      u = create_sessions(:login => nil)
      u.errors.on(:login).should_not be_nil
    end.should_not change(Sessions, :count)
  end

  it 'requires password' do
    lambda do
      u = create_sessions(:password => nil)
      u.errors.on(:password).should_not be_nil
    end.should_not change(Sessions, :count)
  end

  it 'requires password confirmation' do
    lambda do
      u = create_sessions(:password_confirmation => nil)
      u.errors.on(:password_confirmation).should_not be_nil
    end.should_not change(Sessions, :count)
  end

  it 'requires email' do
    lambda do
      u = create_sessions(:email => nil)
      u.errors.on(:email).should_not be_nil
    end.should_not change(Sessions, :count)
  end

  it 'resets password' do
    sessions(:quentin).update_attributes(:password => 'new password', :password_confirmation => 'new password')
    Sessions.authenticate('quentin', 'new password').should == sessions(:quentin)
  end

  it 'does not rehash password' do
    sessions(:quentin).update_attributes(:login => 'quentin2')
    Sessions.authenticate('quentin2', 'test').should == sessions(:quentin)
  end

  it 'authenticates sessions' do
    Sessions.authenticate('quentin', 'test').should == sessions(:quentin)
  end

  it 'sets remember token' do
    sessions(:quentin).remember_me
    sessions(:quentin).remember_token.should_not be_nil
    sessions(:quentin).remember_token_expires_at.should_not be_nil
  end

  it 'unsets remember token' do
    sessions(:quentin).remember_me
    sessions(:quentin).remember_token.should_not be_nil
    sessions(:quentin).forget_me
    sessions(:quentin).remember_token.should be_nil
  end

  it 'remembers me for one week' do
    before = 1.week.from_now.utc
    sessions(:quentin).remember_me_for 1.week
    after = 1.week.from_now.utc
    sessions(:quentin).remember_token.should_not be_nil
    sessions(:quentin).remember_token_expires_at.should_not be_nil
    sessions(:quentin).remember_token_expires_at.between?(before, after).should be_true
  end

  it 'remembers me until one week' do
    time = 1.week.from_now.utc
    sessions(:quentin).remember_me_until time
    sessions(:quentin).remember_token.should_not be_nil
    sessions(:quentin).remember_token_expires_at.should_not be_nil
    sessions(:quentin).remember_token_expires_at.should == time
  end

  it 'remembers me default two weeks' do
    before = 2.weeks.from_now.utc
    sessions(:quentin).remember_me
    after = 2.weeks.from_now.utc
    sessions(:quentin).remember_token.should_not be_nil
    sessions(:quentin).remember_token_expires_at.should_not be_nil
    sessions(:quentin).remember_token_expires_at.between?(before, after).should be_true
  end

protected
  def create_sessions(options = {})
    record = Sessions.new({ :login => 'quire', :email => 'quire@example.com', :password => 'quire', :password_confirmation => 'quire' }.merge(options))
    record.save
    record
  end
end
