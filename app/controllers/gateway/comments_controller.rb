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
      project_coverage: params[:project_coverage],
      patch_coverage: params[:patch_coverage]
    }
  end
end
