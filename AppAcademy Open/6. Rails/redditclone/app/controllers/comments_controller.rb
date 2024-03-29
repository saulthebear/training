class CommentsController < ApplicationController
  before_action :require_login

  def show
    @comment = Comment.find_by(id: params[:id])
  end

  def new
    @comment = Comment.new(post_id: params[:post_id])
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author = current_user

    if @comment.save
      redirect_to post_url(@comment.post_id)
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :parent_comment_id)
  end
end
