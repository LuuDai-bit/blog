class User::AnnouncementsController < User::UserController
  def index
    @announcements = Announcement.display
  end
end
