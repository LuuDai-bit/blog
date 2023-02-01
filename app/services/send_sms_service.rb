# frozen_string_literal: true

class SendSmsService < BaseService
  def initialize(phone_number, message)
    @phone_number = phone_number
    @message = message
  end

  def run
    credentials = Aws::Credentials.new(Rails.application.credentials.dig(:aws, :sns, :access_key_id), Rails.application.credentials.dig(:aws, :sns, :secret_access_key))
    sns = Aws::SNS::Client.new(region: 'us-east-2', credentials: credentials)
    sns.publish({ phone_number: phone_number, message: message })
  end

  private
  attr_reader :phone_number, :message
end
