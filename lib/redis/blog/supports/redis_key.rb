module Blog::Supports::RedisKey
  def log_access_count_by_ip(ip)
    "log:ip:#{ip}:access_count"
  end
end
