class AddColumnsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :device_id, :string, array: true, default:[]
  end
end
