class UsersController < ApplicationController
  def index
    # /users GET
    render json: User.all
  end
  
  def create
    # /users POST
    user = User.new(user_params)

    if user.save
      render json: user
    else
      render json: user.errors.full_messages, status: :unprocessable_entitiy
    end
  end

  # def new
  #   # /users/new GET
  # end

  # def edit
  #   # /users/:id/edit GET
  # end

  def show
    # /users/:id GET
    user = User.find(params[:id])
    render json: user
  end

  def update
    # /users/:id PATCH PUT
    user = User.find(params[:id])
    if user.update_attributes(user_params)
      render json: user
    else
      render json: user.errors.full_messages, status: :unprocessable_entitiy
    end
  end

  def destroy
    # /users/:id DELETE
    User.destroy(params[:id])
    render plain: "User #{params[:id]} was destroyed!"
  end
  
  private

  def user_params
    params.require(:user).permit(:username)
  end
end
