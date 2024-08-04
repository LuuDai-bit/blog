class AddTargetDateToReminders < ActiveRecord::Migration[7.1]
  def change
    add_column :reminders, :target_date, :datetime, null: false, default: Time.current
  end
end
