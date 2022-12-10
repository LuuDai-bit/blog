class Admin::PostsController < ApplicationController
  def index
    @pagy, @posts = pagy(Post.includes(:author))
  end

  def show
    @post = Post.find params[:id]
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new create_post_params

    if @post.save
      redirect_to admin_posts_path
    else
      render :new
    end
  end

  private

  def create_post_params
    params.require(:post).permit(:subject, :content)
  end
end
