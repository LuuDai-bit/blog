class Gateway::ApplicationController < ActionController::API
  class AuthenticationError < StandardError; end

  before_action :authenticate

  private

  def authenticate
    auth_token = AuthToken.find_by(token: token)

    raise AuthenticationError if auth_token.blank?
  end

  def token
    request.headers['Token'] || request.headers['token']
  end
end
