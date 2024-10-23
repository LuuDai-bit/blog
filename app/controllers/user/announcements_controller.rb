class AnnouncementsController < AdminController
  def index
    @announcements = Announcement.display
  end
end
