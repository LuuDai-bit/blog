class User::IdleTalksController < User::UserController
  def index
    @pagy, @posts = pagy(IdleTalk.status_publish
                                 .by_subject(filter_params[:search_text])
                                 .merge(Category.by_name(filter_params[:category_name]))
                                 .by_locale
                                 .order(release_date: :desc)
                                 .left_joins(:categories)
                                 .preload(:categories, :author)
                                 .distinct
                        )
  end

  def show
    @post = Blog::Cache::PostProxy.show(params[:id], I18n.locale)
  end

  private

  def filter_params
    @filter_params ||= params.permit(:search_text, :category_name)
  end
end
