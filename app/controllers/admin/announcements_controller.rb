class Admin::AnnouncementsController < Admin::AdminController
  before_action :load_announcement, only: %i[update]

  def index
    @pagy, @announcements = pagy(current_user.announcements)
  end

  def new
    @announcement = Announcement.new
  end

  def create
    @announcement = current_user.announcements.new(announcement_params)

    if @announcement.save
      flash[:notice] = 'Announcement created'
      redirect_to admin_announcements_path
    else
      flash[:alert] = 'Announcement create failed'
      render :new
    end
  end

  def update
    if @announcement.update(announcement_params)
      flash[:notice] = 'Post updated'
      redirect_to admin_announcements_path
    else
      flash[:alert] = 'Post update failed'
    end
  end

  private

  def load_announcement
    @announcement = Announcement.find(params[:id])
  end

  def announcement_params
    params.require(:announcement).permit(%i[content activated])
  end
end
