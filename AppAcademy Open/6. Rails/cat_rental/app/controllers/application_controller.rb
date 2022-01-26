class ApplicationController < ActionController::Base
  helper_method :current_user, :login_user!, :logged_in?, :redirect_if_loggedin
  
  def current_user
    session_token = session[:session_token]
    return nil unless session_token

    @current_user ||= User.find_by(session_token: session_token)
  end
  
  def login_user!(user)
    session_token = user.reset_session_token!
    session[:session_token] = session_token
  end
  
  def logged_in?
    return true if current_user

    return false
  end
  
  def redirect_if_loggedin
    redirect_to cats_url if logged_in?
  end
end
