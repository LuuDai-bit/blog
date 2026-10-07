class AddPostTypeToCategories < ActiveRecord::Migration[8.1]
  def change
    add_column :categories, :post_type, :string, null: false, default: 'TechnicalPost'
  end
end
