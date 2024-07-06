class User::PostsController < User::UserController
  def index
    @pagy, @posts = pagy(Post.status_publish
                             .by_subject(filter_params[:search_text])
                             .merge(Category.by_name(filter_params[:category_name]))
                             .by_locale
                             .order(id: :desc)
                             .left_joins(:categories)
                             .preload(:categories, :author)
                             .distinct
                    )
  end

  def show
    @post = Post.by_locale.find params[:id]
    @post.update(views: @post.views + 1)
  end

  private

  def filter_params
    params.permit(:search_text, :category_name)
  end
end
