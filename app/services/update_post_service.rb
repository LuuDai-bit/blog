# frozen_string_literal: true

class UpdatePostService < BaseService
  def initialize(post, params)
    @post = post
    @params = params
  end

  def run
    post.assign_attributes(prepared_params)
    post.save
  end

  private
  attr_reader :post, :params

  def prepared_params
    if post.status.eql?(Settings.enum.post.status.draft) &&
         params[:status].eql?(Settings.enum.post.status.publish)
      return params.merge(created_at: Time.current)
    end

    params
  end
end
