class SessionsController < ApplicationController
  # Login form
  def new
    render :new
  end

  # Login
  def create
    user = User.find_by_credentials(
      session_params[:email],
      session_params[:password]
    )

    if user
      login_user!(user)
      redirect_to users_url
    else
      flash.now[:errors] = ['Incorrect email or password']
      render :new
    end
  end

  # Logout
  def destroy
    logout!
    redirect_to users_url
  end

  private

  def session_params
    params.require(:user).permit(:email, :password)
  end
end
