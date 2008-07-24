module AuthenticatedSystem
  protected
    # Returns true or false if the sessions is logged in.
    # Preloads @current_sessions with the sessions model if they're logged in.
    def logged_in?
      !!current_sessions
    end

    # Accesses the current sessions from the session. 
    # Future calls avoid the database because nil is not equal to false.
    def current_sessions
      @current_sessions ||= (login_from_session || login_from_basic_auth || login_from_cookie) unless @current_sessions == false
    end

    # Store the given sessions id in the session.
    def current_sessions=(new_sessions)
      session[:sessions_id] = new_sessions ? new_sessions.id : nil
      @current_sessions = new_sessions || false
    end

    # Check if the sessions is authorized
    #
    # Override this method in your controllers if you want to restrict access
    # to only a few actions or if you want to check if the sessions
    # has the correct rights.
    #
    # Example:
    #
    #  # only allow nonbobs
    #  def authorized?
    #    current_sessions.login != "bob"
    #  end
    def authorized?
      logged_in?
    end

    # Filter method to enforce a login requirement.
    #
    # To require logins for all actions, use this in your controllers:
    #
    #   before_filter :login_required
    #
    # To require logins for specific actions, use this in your controllers:
    #
    #   before_filter :login_required, :only => [ :edit, :update ]
    #
    # To skip this in a subclassed controller:
    #
    #   skip_before_filter :login_required
    #
    def login_required
      authorized? || access_denied
    end

    # Redirect as appropriate when an access request fails.
    #
    # The default action is to redirect to the login screen.
    #
    # Override this method in your controllers if you want to have special
    # behavior in case the sessions is not authorized
    # to access the requested action.  For example, a popup window might
    # simply close itself.
    def access_denied
      respond_to do |format|
        format.html do
          store_location
          redirect_to new_session_path
        end
        format.any do
          request_http_basic_authentication 'Web Password'
        end
      end
    end

    # Store the URI of the current request in the session.
    #
    # We can return to this location by calling #redirect_back_or_default.
    def store_location
      session[:return_to] = request.request_uri
    end

    # Redirect to the URI stored by the most recent store_location call or
    # to the passed default.
    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end

    # Inclusion hook to make #current_sessions and #logged_in?
    # available as ActionView helper methods.
    def self.included(base)
      base.send :helper_method, :current_sessions, :logged_in?
    end

    # Called from #current_sessions.  First attempt to login by the sessions id stored in the session.
    def login_from_session
      self.current_sessions = Sessions.find_by_id(session[:sessions_id]) if session[:sessions_id]
    end

    # Called from #current_sessions.  Now, attempt to login by basic authentication information.
    def login_from_basic_auth
      authenticate_with_http_basic do |username, password|
        self.current_sessions = Sessions.authenticate(username, password)
      end
    end

    # Called from #current_sessions.  Finaly, attempt to login by an expiring token in the cookie.
    def login_from_cookie
      sessions = cookies[:auth_token] && Sessions.find_by_remember_token(cookies[:auth_token])
      if sessions && sessions.remember_token?
        cookies[:auth_token] = { :value => sessions.remember_token, :expires => sessions.remember_token_expires_at }
        self.current_sessions = sessions
      end
    end
end
