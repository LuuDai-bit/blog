require 'notification_services/base'

module NotificationServices
  class Gmail < Base
    def send_notification(recipient, message)
      unless eligible?(destination)
        raise ArgumentError, "Invalid email address: #{destination}"
      end

      ReminderMailer.send_notification(destination, recipient, message).deliver_later
    end

    private

    def eligible?(destination)
      URI::MailTo::EMAIL_REGEXP.match?(destination)
    end
  end
end
