require 'notification_services/base'
require 'twilio-ruby'

module NotificationServices
  class SMS < Base
    def send_notification(recipient, message)
      unless eligible?(destination)
        raise 'Destination not eligible for Twilio notifications'
      end

      from = "whatsapp:#{ENV['TWILIO_PHONE_NUMBER']}"
      to = "whatsapp:#{destination}"

      @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
      message = @client.messages.create(
        body: message,
        to: to,
        from: from,
      )

      message.sid
    end

    private

    def eligible?(destination)
      Phony.plausible?(destination)
    end
  end
end
