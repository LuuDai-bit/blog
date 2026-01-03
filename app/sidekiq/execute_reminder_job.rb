class ExecuteReminderJob
  include Sidekiq::Job

  def perform(reminder_id, user_id)
    reminder = Reminder.find(reminder_id)
    user = User.find(user_id)

    notification_service = Factories::Notification::ReminderCreator.new(reminder.notification_type).create
    notification_service.send_notification(destination, reminder.title, reminder.content)

    reminder.destroy! if reminder.only_once

    JobLog.create(job_name: self.class.name)
  end
end
