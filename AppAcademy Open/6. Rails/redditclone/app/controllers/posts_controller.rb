class PostsController < ApplicationController
  before_action :require_login, except: :show

  before_action only: %i[edit update destroy] do
    @post = Post.find_by(id: params[:id])
    require_authorization(@post.author)
  end

  def show
    @post = Post.includes(:comments).find_by(id: params[:id])
    @all_comments = @post.comments.includes(:author)

    @top_level_comments = @all_comments.filter do |comment|
      comment.parent_comment_id.nil?
    end

    render :show
  end

  def new
    @post = Post.new
    @subs = Sub.all
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user

    if @post.save
      redirect_to post_url(@post)
    else
      @subs = Sub.all
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
    @subs = Sub.all
    render :edit
  end

  def update
    @post = Post.find_by(id: params[:id])

    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      @subs = Sub.all
      render :edit
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy!
    redirect_to :root
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end
end
