# frozen_string_literal: true

class SendReminderEmailService < BaseService
  def initialize(title, message)
    @message = message
  end

  def run
    credentials = Aws::Credentials.new(Rails.application.credentials.dig(:aws, :sns, :access_key_id), Rails.application.credentials.dig(:aws, :sns, :secret_access_key))
    sns = Aws::SNS::Client.new(region: 'us-east-2', credentials: credentials)
    sns.publish({ topic_arn: ENV.fetch('SNS_REMINDER_ARN'), subject: title, message: message })
  end

  private
  attr_reader :title, :message
end
