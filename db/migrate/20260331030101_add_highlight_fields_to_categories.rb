class AddHighlightFieldsToCategories < ActiveRecord::Migration[8.1]
  def change
    add_column :categories, :highlighted, :boolean, default: false
    add_column :categories, :highlight_order, :integer
  end
end
