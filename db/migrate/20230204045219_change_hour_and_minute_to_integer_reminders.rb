class ChangeHourAndMinuteToIntegerReminders < ActiveRecord::Migration[6.1]
  def up
    change_column :reminders, :hour, 'integer USING CAST(hour AS integer)', null: false
    change_column :reminders, :minute, 'integer USING CAST(minute AS integer)', null: false
  end

  def down
    change_column :reminders, :hour, :string, null: false
    change_column :reminders, :minute, :string, null: false
  end
end
