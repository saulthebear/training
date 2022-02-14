class ApplicationController < ActionController::Base
  helper_method :current_user,
                :login!,
                :logout!,
                :require_authorization

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

  ##
  # if no user is passed, this function returns true if any user is logged in.
  # Otherwise, the specific user passed mused be logged_in for this function to
  # return true.
  #
  # returns true if user is logged in
  # redirects to login page and returns false if user is not logged in
  def require_authorization(user = nil)
    if current_user
      return true if user.nil? || current_user == user
    else
      redirect_to new_session_url
      false
    end
  end
end
