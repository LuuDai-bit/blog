class GenerateReminderJob
  # TODO: Deprecated. Will remove before the sidekiq service terminated
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

      # TODO: Deprecated. Will remove before the sidekiq service terminated
      ExecuteReminderJob.perform_at(execute_time, user_reminder.reminder_id, user_reminder.user_id)

      # Newly job service. Testing
      params = {
        name: "execute_reminder",
        reminder_id: user_reminder.reminder_id,
        user_id: user_reminder.user_id
      }
      RedisModel::Event.create(queue: 'default_jobs', params: params)
    end

    JobLog.create(job_name: self.class.name)
  end
end
