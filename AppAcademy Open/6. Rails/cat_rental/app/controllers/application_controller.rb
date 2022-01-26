class ApplicationController < ActionController::Base
  helper_method :current_user
  
  def current_user
    session_token = session[:session_token]
    return nil unless session_token

    @current_user ||= User.find_by(session_token: session_token)
  end
  
  def login_user!(user)
    session_token = user.reset_session_token!
    session[:session_token] = session_token
  end
end
