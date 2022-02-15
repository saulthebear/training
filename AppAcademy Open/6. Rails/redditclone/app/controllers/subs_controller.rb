class SubsController < ApplicationController
  before_action :require_login, only: %i[edit update]

  def index
    @subs = Sub.all
  end

  def show
    @sub = Sub.find_by(id: params[:id])
    if @sub
      render :show
    else
      redirect_to :root
    end
  end

  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator = current_user

    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find_by(id: params[:id])
    if @sub
      render :edit
    else
      redirect_to :root
    end
  end

  def update
    @sub = Sub.find_by(id: params[:id])
    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def destroy
    @sub = Sub.find_by(id: params[:id])

    # Only the sub's moderator can delete it
    unless @sub.moderator == current_user
      redirect_to sub_url(@sub)
      return
    end

    if @sub.moderator == current_user
      @sub.destroy!
      redirect_to :root
    else
      redirect_to sub_url(@sub)
    end
  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
