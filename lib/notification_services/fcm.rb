module NotificationServices
  class FCM < Base
    def send_notification(recipient, message)
      # Add implementation for sending notification via FCM
      unless eligible?(destination)
        raise "Destination not eligible for FCM notifications"
      end

      puts "Sending FCM notification to #{recipient}: #{message}"
    end

    private

    def eligible?(destination)
      # Add logic to check if the destination is eligible for FCM
    end
  end
end
