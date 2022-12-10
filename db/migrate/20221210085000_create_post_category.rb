class CreatePostCategory < ActiveRecord::Migration[6.1]
  def change
    create_table :post_categories do |t|
      t.references :post, foreign_key: true
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
