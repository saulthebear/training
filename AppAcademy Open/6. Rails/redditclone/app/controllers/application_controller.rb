class ApplicationController < ActionController::Base
  helper_method :current_user,
                :login!,
                :logout!,
                :require_login

  def current_user
    token = session[:session_token]
    return nil unless token

    @current_user ||= User.find_by_session_token(token)
  end

  def login!(user)
    token = user.reset_session_token!
    session[:session_token] = token
    @current_user = user
  end

  def logout!
    return if current_user.nil?

    @current_user.reset_session_token!
    session[:session_token] = nil
  end

  def require_login
    unless current_user
      flash[:errors] = ['You must be logged in to perform this action']
      redirect_to new_session_url
    end
  end

  def require_authorization(user)
    unless current_user == user
      flash[:errors] = ['You are not authorized to perform this action']
      redirect_to :root
    end
  end
end
