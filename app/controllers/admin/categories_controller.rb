class Admin::CategoriesController < Admin::AdminController
  before_action :set_category, only: %i[edit update]

  def index
    @pagy, @categories = pagy(Category.highlighted_and_id_ordered)
  end

  def edit; end

  def update
    if @category.update(category_params)
      redirect_to admin_categories_path, flash: { success: 'Category was successfully updated.' }
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:highlighted, :highlight_order)
  end
end
