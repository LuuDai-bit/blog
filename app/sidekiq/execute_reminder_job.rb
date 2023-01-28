class ExecuteReminderJob
  include Sidekiq::Job

  def perform(content, phone_number)
    SendSmsService.run(content, phone_number)
  end
end
