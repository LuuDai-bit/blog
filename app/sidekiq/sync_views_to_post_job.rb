class SyncViewsToPostJob
  def perform
    params = {}
    json_string_params = JSON.generate(params)
    params_string = "sync_views_to_post_job^-#{json_string_params}"
    event_id = RedisModel::Event.create(queue: 'default_jobs', params: params_string)
    JobLog.create(job_name: self.class.name, event_id: event_id)
  end

  private

  def redis
    @redis ||= Blog::RedisClient.new
  end
end
