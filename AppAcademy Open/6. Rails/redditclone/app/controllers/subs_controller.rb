class SubsController < ApplicationController
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
    return unless require_authorization

    @sub = Sub.new
    render :new
  end

  def create
    return unless require_authorization

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
    return unless require_authorization(@sub.moderator)

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
