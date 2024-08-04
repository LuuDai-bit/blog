class RemoveMinuteAndHourColumnFromReminders < ActiveRecord::Migration[7.1]
  def up
    update_target_date_sql
    remove_columns :reminders, :hour, :minute
  end

  def down
    add_column :reminders, :hour, :integer, null: false, default: 0
    add_column :reminders, :minute, :integer, null: false, default: 0
  end

  private

  def update_target_date_sql
    reminder_update_attrs = []
    reminders.find_each do |reminder|
      target_date = Time.current.beginning_of_day
                        .since(reminder.hour.hour)
                        .since(reminder.minute.minute)
      reminder.assign_attributes(target_date: target_date)
      reminder_update_attrs << reminder.attributes
    end

    Reminder.upsert_all(reminder_update_attrs)
  end

  def reminders
    @reminders ||= Reminder.all
  end
end
