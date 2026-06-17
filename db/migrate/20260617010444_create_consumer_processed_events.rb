class CreateConsumerProcessedEvents < ActiveRecord::Migration[8.1]
  def change
    create_table :consumer_processed_events do |t|
      t.string :vendor, null: false
      t.string :event_id, null: false
      t.string :status, default: 'failed', null: false

      t.timestamps
    end
  end
end
