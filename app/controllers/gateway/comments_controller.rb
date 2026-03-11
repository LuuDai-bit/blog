require 'httparty'

class Gateway::CommentsController < Gateway::ApplicationController
  def create
    CommentGrpcClient.new.create_comment(owner: params[:owner],
                                         repo: params[:repo],
                                         pr: params[:pull_request_number].to_i,
                                         variables: params.to_unsafe_h.except(*filtered_params))

    render json: { message: 'Success' }

  rescue StandardError => e
    render json: { message: 'Failed', exception: e.message }, status: :internal_server_error
  end

  private

  def filtered_params
    %i[owner repo controller action comment pull_request_number]
  end
end
