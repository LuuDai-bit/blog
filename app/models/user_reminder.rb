class UserReminder < ApplicationRecord
  belongs_to :user
  belongs_to :reminder

  after_create :schedule_reminder_init

  private

  def schedule_reminder_init
    current_time = Time.now
    current_hour = current_time.hour
    current_minute = current_time.strftime('%M').to_i

    return if reminder.day.exclude?(current_time.strftime('%a')) || (reminder.hour.to_i <= current_hour && reminder.minute.to_i < current_minute)

    execute_time = current_time.beginning_of_day.since(reminder.hour.to_i.hour).since(reminder.minute.to_i.minute)

    ExecuteReminderJob.perform_at(execute_time, reminder_id, user_id)
  end
end
