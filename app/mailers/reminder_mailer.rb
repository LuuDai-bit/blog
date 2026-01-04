class ReminderMailer < ApplicationMailer
  def send_notification(email_address, title, body)
    @title = title
    @body = body
    mail(to: email_address, subject: @title, body: @body)
  end
end
