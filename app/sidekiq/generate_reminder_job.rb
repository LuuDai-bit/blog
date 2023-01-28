class GenerateReminderJob
  include Sidekiq::Job

  def perform
    user_reminders = UserReminder.all.inlcudes(:user, :reminder)
    current_time = Time.now

    user_reminders.each do |user_reminder|
      reminder = user_reminder.reminder
      user = user_reminder.user
      execute_time = current_time.since(reminder.hour).since(reminder.minute)

      ExecuteReminderJob.perform_at(execute_time, reminder.content, user.phone_number)
    end
  end
end
