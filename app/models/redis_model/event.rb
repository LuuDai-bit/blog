module RedisModel
  class Event < RedisModel::ApplicationRecord
    DEFAULT_JOB_KEY = 'default_jobs'.freeze
    ALLOW_QUEUES = %w(default_jobs low_priority_jobs critcal_jobs).freeze
    EXPIRE_TIME = 5 #seconds

    def self.create(queue:, params:)
      queue = DEFAULT_JOB_KEY unless ALLOW_QUEUES.include?(queue)
      current_timestamp = Time.now.to_i
      key = "#{queue}:#{current_timestamp}"

      redis.client.set(key, params, ex: EXPIRE_TIME)
    end
  end
end
