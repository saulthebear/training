class ApplicationController < ActionController::Base
  helper_method :current_user

  def login!(user)
    @user = user
    session[:session_token] = user.session_token
  end
  
  def logout!
    current_user.try(:reset_sesion_token!)
    session[:session_token] = nil
  end

  def current_user
    return nil if session[:session_token].nil?

    @user ||= User.find_by(session_token: session[:session_token])
  end
  
  def require_current_user!
    redirect_to new_session_url if current_user.nil?
  end
end
