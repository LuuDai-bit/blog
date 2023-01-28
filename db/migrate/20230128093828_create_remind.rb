class CreateRemind < ActiveRecord::Migration[6.1]
  def change
    create_table :reminders do |t|
      t.string :title
      t.string :content, null: false, limit: 60 # Viettel limit is 70 character
      t.json :day, null: false
      t.string :hour, null: false
      t.string :minute, null: false
      t.boolean :only_once, null: false, default: false

      t.timestamps
    end
  end
end
