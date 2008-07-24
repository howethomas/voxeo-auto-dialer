module AuthenticatedTestHelper
  # Sets the current sessions in the session from the sessions fixtures.
  def login_as(sessions)
    @request.session[:sessions_id] = sessions ? sessions(sessions).id : nil
  end

  def authorize_as(user)
    @request.env["HTTP_AUTHORIZATION"] = user ? ActionController::HttpAuthentication::Basic.encode_credentials(users(user).login, 'test') : nil
  end
end
