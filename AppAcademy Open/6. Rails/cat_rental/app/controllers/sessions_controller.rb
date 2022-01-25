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
      user.reset_session_token!
      redirect_to cats_url
    else
      flash.now[:errors] = ["Invalid login details"]
      render :new
    end
  end
  
  private

  def session_params
    params.require(:user).permit(:username, :password)
  end
end