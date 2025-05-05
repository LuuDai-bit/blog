class AddReleaseDateToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :release_date, :date
  end
end
