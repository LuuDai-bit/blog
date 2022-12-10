class Admin::PostsController < ApplicationController
  def index
    @pagy, @posts = pagy(Post.all)
  end

  def new
    @post = Post.new
  end

  def create
    if @post.create create_post_params
      redirect_to :index
    else
      render :new
    end
  end

  private

  def create_post_params
    params.require(:post).permit(:subject, :content)
  end
end
