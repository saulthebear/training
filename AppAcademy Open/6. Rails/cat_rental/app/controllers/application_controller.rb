class ApplicationController < ActionController::Base
  helper_method :current_user
  
  def current_user
    session_token = session[:session_token]
    return nil unless session_token

    @current_user ||= User.find_by(session_token: session_token)
  end
end
