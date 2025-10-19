class DeactivateAnnouncementJob
  include Sidekiq::Job

  def perform
    announcements = Announcement.active.where('end_at < ?', Time.current)
    announcements.update_all(activated: false)

    JobLog.create(job_name: self.class.name)
  end
end
