class CreateAnnouncements < ActiveRecord::Migration[7.1]
  def change
    create_table :announcements do |t|
      t.string :content, null: false
      t.boolean :activated, null: false, default: true
      t.references :user, foreign_key: true, null: false
      t.datetime :start_at
      t.integer :duration

      t.timestamps
    end
  end
end
