class GenerateReminderJob
  include Sidekiq::Job

  def perform
    user_reminders = UserReminder.all.includes(:reminder)
    current_time = Time.now

    user_reminders.each do |user_reminder|
      reminder = user_reminder.reminder

      next if reminder.day.exclude?(current_time.strftime('%a'))

      target_hour = reminder.target_date.strftime("%H").to_i
      target_minute = reminder.target_date.strftime("%M").to_i
      execute_time = current_time.beginning_of_day.since(target_hour.hour).since(target_minute.minute)

      ExecuteReminderJob.perform_at(execute_time, user_reminder.reminder_id, user_reminder.user_id)
    end
  end
end
