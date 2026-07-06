class DeactivateAnnouncementJob
  def perform
    JobLog.create(job_name: self.class.name)

    params = {
      current_time: Time.current
    }
    json_string_params = JSON.generate(params)
    params_string = "deactivate_announcement_job^-#{json_string_params}"
    RedisModel::Event.create(queue: 'default_jobs', params: params_string)
  end
end
