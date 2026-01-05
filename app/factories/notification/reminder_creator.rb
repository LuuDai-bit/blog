require 'notification_services/gmail'
require 'notification_services/sms'
require 'notification_services/fcm'

module Notification
  class ReminderCreator < NotificationCreator
    def initialize(notification_type, user)
      @notification_type = notification_type
      @user = user
    end

    def create
      unless VALID_NOTIFICATION_TYPES.include?(notification_type)
        raise ArgumentError, "Invalid notification type: #{notification_type}"
      end

      case notification_type
      when 'email'
        ::NotificationServices::Gmail.new(user.email)
      when 'sms'
        ::NotificationServices::SMS.new(user.phone_number)
      when 'push'
        ::NotificationServices::FCM.new(user.device_id)
      else
        raise ArgumentError, "Unsupported notification type: #{notification_type}"
      end
    end

    private

    attr_reader :notification_type, :user
  end
end
