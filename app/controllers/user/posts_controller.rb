class User::PostsController < User::UserController
  def index
    @pagy, @posts = pagy(Post.status_publish
                             .by_subject(params[:search_text])
                             .includes(:author)
                             .order(id: :desc))
  end

  def show
    @post = Post.find params[:id]
    @post.views += 1
    @post.save!
  end
end
