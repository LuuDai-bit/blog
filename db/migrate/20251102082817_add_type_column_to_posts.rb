class AddTypeColumnToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :type, :string, default: 'TechnicalPost'
  end
end
