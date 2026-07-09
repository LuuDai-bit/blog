class DeactivateAnnouncementJob
  def perform
    params = {
      current_time: Time.current
    }
    json_string_params = JSON.generate(params)
    params_string = "deactivate_announcement_job^-#{json_string_params}"
    event_id = RedisModel::Event.create(queue: 'default_jobs', params: params_string)
    JobLog.create(job_name: self.class.name, event_id: event_id)
  end
end
