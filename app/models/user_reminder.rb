class UserReminder < ApplicationRecord
  belongs_to :user
  belongs_to :reminder

  after_create :schedule_reminder_init

  private

  def schedule_reminder_init
    current_time = Time.now
    current_hour = current_time.hour
    current_minute = current_time.strftime('%M').to_i

    target_hour = reminder.target_date.strftime("%H").to_i
    target_minute = reminder.target_date.strftime("%M").to_i
    return if reminder.day.exclude?(current_time.strftime('%a')) || (target_hour <= current_hour && target_minute < current_minute)

    execute_time = current_time.beginning_of_day.since(target_hour.hour).since(target_minute.minute)

    ExecuteReminderJob.perform_at(execute_time, reminder_id, user_id)
  end
end
