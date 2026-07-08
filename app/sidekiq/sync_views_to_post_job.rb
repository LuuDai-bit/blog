class SyncViewsToPostJob
  def perform
    JobLog.create(job_name: self.class.name)

    # Newly job service. Testing
    params = {}
    json_string_params = JSON.generate(params)
    params_string = "sync_views_to_post_job^-#{json_string_params}"
    RedisModel::Event.create(queue: 'default_jobs', params: params_string)
  end

  private

  def redis
    @redis ||= Blog::RedisClient.new
  end
end
