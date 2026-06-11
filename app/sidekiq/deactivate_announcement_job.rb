class DeactivateAnnouncementJob
  # TODO: Deprecated. Will remove before the sidekiq service terminated
  include Sidekiq::Job

  def perform
    # TODO: Deprecated. Will remove before the sidekiq service terminated
    announcements = Announcement.active.where('end_at < ?', Time.current)
    announcements.update_all(activated: false)

    JobLog.create(job_name: self.class.name)

    # Newly job service. Testing
    params = {
      name: "deactivate_announcement",
      current_time: Time.current
    }
    RedisModel::Event.create(queue: 'default_jobs', params: params)
  end
end
