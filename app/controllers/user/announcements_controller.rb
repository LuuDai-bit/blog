class AnnouncementsController < AdminController
  def index
    @announcements = Announcement.active
  end
end
