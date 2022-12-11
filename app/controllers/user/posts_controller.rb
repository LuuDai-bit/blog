class PostsController < UserController
  def index
    @pagy, @posts = pagy(Post.includes(:author))
  end

  def show
    @post = Post.find params[:id]
  end
end
