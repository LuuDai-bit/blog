class AddOriginalTimeZoneToReminders < ActiveRecord::Migration[6.1]
  def change
    add_column :reminders, :original_timezone, :integer, default: 0
  end
end
