module RedisModel
  class ApplicationRecord
    def self.redis
      @redis ||= Blog::RedisClient.new(ENV.fetch('EVENT_REDIS_DB'))
    end
  end
end
