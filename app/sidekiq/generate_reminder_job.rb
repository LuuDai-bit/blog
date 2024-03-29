class GenerateReminderJob
  include Sidekiq::Job

  def perform
    user_reminders = UserReminder.all.includes(:user, :reminder)
    current_time = Time.now

    user_reminders.each do |user_reminder|
      reminder = user_reminder.reminder

      next if reminder.day.exclude?(current_time.strftime('%a'))

      user = user_reminder.user
      execute_time = current_time.beginning_of_day.since(reminder.hour.to_i.hour).since(reminder.minute.to_i.minute)

      ExecuteReminderJob.perform_at(execute_time, user_reminder.reminder_id, user_reminder.user_id)
    end
  end
end
