class CreateUser < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name, null: false, limit: 50
      t.string :email, null: false

      t.timestamps

      t.index :email, unique: true
    end
  end
end
