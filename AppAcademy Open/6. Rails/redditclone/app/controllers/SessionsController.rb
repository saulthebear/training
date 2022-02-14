class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    username = params[:user][:username]
    password = params[:user][:password]
    @user = User.find_by_credentials(username, password)
    if @user
      login!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = ['Incorrect username and password combination']
      @user = User.new(username: username)
      render :new
    end
  end

  def destroy
    logout!
    redirect_to users_url
  end
end
