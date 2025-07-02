module Blog::Supports::RedisKey
  def log_access_count_by_ip(ip)
    "log:ip:#{ip}:access_count"
  end

  def post_caching(post_id, locale)
    "post_caching:#{post_id}:#{locale}"
  end

  def post_cached(post_id, locale)
    "post_cached:#{post_id}:#{locale}"
  end

  def post_views
    "post_view"
  end
end
