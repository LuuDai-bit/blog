class ApplicationController < ActionController::Base
  include Pagy::Backend

  before_action do
    too_many_requests if log.access_count > ENV.fetch('MAX_REQUEST_ALLOW').to_i
  end

  after_action do
    log.access_count += 1
    log.save!
  end

  private

  def log
    @log ||= Log.where('DATE(created_at) = CURRENT_DATE')
                .find_or_initialize_by(ip_address: request.remote_ip)
  end

  def too_many_requests
    render file: 'public/429.html', status: :too_many_requests, layout:false
  end
end
