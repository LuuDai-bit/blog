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
      flash[:notice] = 'Announcement updated'
      redirect_to admin_announcements_path
    else
      flash[:alert] = 'Announcement update failed'
    end
  end

  private

  def load_announcement
    @announcement = Announcement.find(params[:id])
  end

  def announcement_params
    params.require(:announcement).permit(%i[content activated duration]).tap do |param|
      if param[:activated]
        param[:start_at] = Time.current

        if param[:duration].present?
          param[:end_at] = Time.current.since(param[:duration].to_i)
        else
          param[:end_at] = nil
        end
      end
    end
  end
end
