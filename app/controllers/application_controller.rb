class ApplicationController < ActionController::Base
  include Pagy::Backend

  before_action do
    key = redis.log_access_count_by_ip(request.remote_ip)
    redis.client.incr(key)
    too_many_requests if exceed_rate_limit?(key)

    redis.client.expire(key, ENV.fetch('RATE_LIMIT_TIME'))
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

  def redis
    @redis ||= Blog::RedisClient.new
  end

  def exceed_rate_limit?(key)
    redis.client.get(key).to_i > ENV.fetch('MAX_REQUEST_ALLOW').to_i
  end
end
