require 'notification_services/base'

module NotificationServices
  class Email < Base
    def send_notification(recipient, message)
      unless eligible?(recipient)
        raise ArgumentError, "Invalid email address: #{recipient}"
      end

      ReminderMailer.send_notification(recipient, recipient, message).deliver_later
    end

    private

    def eligible?(destination)
      URI::MailTo::EMAIL_REGEXP.match?(destination)
    end
  end
end
