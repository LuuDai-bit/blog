class ExecuteReminderJob
  include Sidekiq::Job

  def perform(reminder_id, user_id)
    reminder = Reminder.find(reminder_id)
    user = User.find(user_id)

    # SendSmsService.run(user.phone_number, reminder.content)
    SendReminderEmailService.run(reminder.title, reminder.content)

    reminder.destroy! if reminder.only_once

    JobLog.create(job_name: self.class.name)
  end
end
