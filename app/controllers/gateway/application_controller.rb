class Gateway::ApplicationController < ActionController::API
  class AuthenticationError < StandardError; end

  include ErrorHandler

  rescue_from AuthenticationError, with: :authentication_error

  before_action :authenticate

  private

  def authenticate
    auth_token = AuthToken.find_by(token: token)

    raise AuthenticationError if auth_token.blank?
  end

  def token
    request.headers['Token'] || request.headers['token']
  end

  def authentication_error
    render json: { message: 'Can not authenticate' }, status: :unauthorized
  end
end
