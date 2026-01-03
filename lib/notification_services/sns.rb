module NotificationServices
  class SNS < Base
    def send_notification(recipient, message)
      # Add implementation for sending notification via SNS
      unless eligible?(destination)
        raise "Destination not eligible for SNS notifications"
      end

      puts "Sending SNS notification to #{recipient}: #{message}"
    end

    private

    def eligible?(destination)
      # Add logic to check if the destination is eligible for SNS
    end
  end
end
