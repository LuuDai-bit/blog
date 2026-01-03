module NotificationServices
  class SES < Base
    def send_notification(recipient, message)
      # Add implementation for sending notification via SES
      unless eligible?(destination)
        raise "Destination not eligible for FCM notifications"
      end
    end

    private

    def eligible?(destination)
      # Add logic to check if the destination is eligible for SES
    end
  end
end
