class SessionsController < ApplicationController
  def new
    render :new
  end
  
  def create
    user = User.find_by_credentials(
      session_params[:username],
      session_params[:password]
    )
    if user
      session_token = user.reset_session_token!
      session[:session_token] = session_token
      redirect_to cats_url
    else
      flash.now[:errors] = ["Invalid login details"]
      render :new
    end
  end
  
  def destroy
    if current_user
      current_user.reset_session_token!
      session[:session_token] = nil
    end

    redirect_to new_session_url
  end
  
  private

  def session_params
    params.require(:user).permit(:username, :password)
  end
end