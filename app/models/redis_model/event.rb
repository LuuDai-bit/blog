module RedisModel
  class Event < RedisModel::ApplicationRecord
    DEFAULT_JOB_KEY = 'default_jobs'.freeze
    ALLOW_QUEUES = %w(default_jobs low_priority_jobs critcal_jobs).freeze
    EXPIRE_TIME = 5 #seconds

    def self.create(queue:, params:)
      return unless ALLOW_QUEUES.include?(queue)

      uuid = SecureRandom.uuid_v7
      key = "#{queue}:#{uuid}"

      redis.client.set(key, params, ex: EXPIRE_TIME)
    end
  end
end
