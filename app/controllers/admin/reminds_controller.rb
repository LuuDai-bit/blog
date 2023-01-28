class Admin::RemindsController < Admin::AdminController
  before_action :load_remind, only: %i(edit update destroy)

  def index
    @pagy, @reminds = pagy(Remind.order(:id))
  end

  def new
    @remind = Remind.new
  end

  def create
    @remind = Remind.new remind_params

    if @remind.save
      flash[:notice] = 'Remind created'
      redirect_to admin_reminds_path
    else
      flash[:alert] = 'Remind create failed'
      render :new
    end
  end

  def edit; end

  def update
    if @remind.update(remind_params)
      flash[:notice] = 'Remind updated'
      redirect_to admin_reminds_path
    else
      flash[:alert] = 'Remind update failed'
      render :edit
    end
  end

  def destroy
    if @remind.destroy
      redirect_to admin_reminds_path
    else
      # Message here
      flash[:alert] = 'Remind destroy failed'
      render :index
    end
  end

  private

  def load_remind
    @remind = Remind.find params[:id]
  end

  def remind_params
    params.require(:remind).permit(:title, :content, :hour, :minute, :only_once, day: []).tap do |param|
      param[:day].reject! { |day| day.empty? }
    end
  end
end
