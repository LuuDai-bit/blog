class Admin::CategoriesController < Admin::AdminController
  def index
    @pagy, @categories = pagy(Category.all)
  end
end
