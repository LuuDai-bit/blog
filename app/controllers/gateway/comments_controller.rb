require 'httparty'

class Gateway::CommentsController < Gateway::ApplicationController
  def create
    domain = ENV['GITHUB_APP_DOMAIN'] || 'http://localhost:3000'
    url = "#{domain}/api/v1/comments"

    HTTParty.post(url, body: body)

    render json: { message: 'Success' }

  rescue StandardError => e
    render json: { message: 'Failed', exception: e.message }, status: :internal_server_error
  end

  private

  def body
    {
      pull_request_number: params[:pull_request_number],
      owner: params[:owner],
      repo: params[:repo],
      variables: params.to_unsafe_h.except(:pull_request_number, :owner, :repo)
    }
  end
end
