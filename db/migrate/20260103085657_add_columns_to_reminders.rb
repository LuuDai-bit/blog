class AddColumnsToReminders < ActiveRecord::Migration[7.1]
  def change
    add_column :reminders, :notification_type, :string, null: false, default: "email"
  end
end
