class ApplicationController < ActionController::Base
  include Pagy::Backend

  before_action do
    key = redis.log_access_count_by_ip(request.remote_ip)
    redis.client.incr(key)
    too_many_requests if exceed_rate_limit?(key)

    redis.client.expire(key, ENV.fetch('RATE_LIMIT_TIME'))
  end

  private

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
