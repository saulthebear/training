class UsersController < ApplicationController
  def index
    render json: User.all
  end

  def show
    render json: User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      login!(@user)
      redirect_to :root
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def edit
    user_id = params[:id]
    @user = User.find(user_id)
    render :edit
  end

  def update
    user_id = params[:id]
    @user = User.find(user_id)

    if @user.update(user_params)
      redirect_to user_url(user_id)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
