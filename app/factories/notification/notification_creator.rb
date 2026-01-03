module Factories
  module Notification
    class NotificationCreator
      VALID_NOTIFICATION_TYPES = %w[email sms push].freeze

      def initialize(notification_type)
        @notification_type = notification_type
      end

      def create
        unless VALID_NOTIFICATION_TYPES.include?(notification_type)
          raise ArgumentError, "Invalid notification type: #{notification_type}"
        end

        case notification_type
        when 'email'
          NotificationServices::SES.new
        when 'sms'
          NotificationServices::SNS.new
        when 'push'
          NotificationServices::SNS.new
        else
          raise ArgumentError, "Unsupported notification type: #{notification_type}"
        end
      end

      private

      attr_reader :notification_type
    end
  end
end
