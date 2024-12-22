class Admin::AboutMeController < Admin::AdminController
  before_action :load_about_me, only: %i[detail update]

  def detail; end

  def update
    if @about_me.update(about_me_params)
      flash[:notice] = 'Announcement created'
      render :detail
    else
      flash[:alert] = 'Announcement create failed'
      render :detail
    end
  end

  private

  def load_about_me
    # Only one about me record
    @about_me = AboutMe.first_or_create
  end

  def about_me_params
    params.require(:about_me).permit(:content, :content_en)
  end
end
