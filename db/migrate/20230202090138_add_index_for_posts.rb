class AddIndexForPosts < ActiveRecord::Migration[6.1]
  def change
    add_index :posts, :subject
    add_index :posts, :status
  end
end
