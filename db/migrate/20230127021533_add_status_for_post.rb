class AddStatusForPost < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :status, :string, default: 'draft'
  end
end
