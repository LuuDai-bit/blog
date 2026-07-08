class CreateRetryEvents < ActiveRecord::Migration[8.1]
  def change
    create_table :retry_events do |t|
      t.string :event_id, null: false
      t.integer :retry_count, default: 0, null: false
      t.string :consumer_name

      t.timestamps

      t.index :event_id, unique: true
    end
  end
end
