class User::PostsController < User::UserController
  def index
    @pagy, @posts = pagy(Post.status_publish
                             .by_subject(params[:search_text])
                             .by_locale
                             .includes(:author)
                             .order(id: :desc))
  end

  def show
    @post = Post.by_locale.find params[:id]
    @post.update(views: @post.views + 1)
  end
end
