class Admin::RemindersController < Admin::AdminController
  before_action :load_reminder, only: %i(edit update destroy)

  def index
    @pagy, @reminders = pagy(Reminder.order(:id))
  end

  def new
    @reminder = Reminder.new
  end

  def create
    @reminder = Reminder.new reminder_params
    @reminder.user_reminders.build(user_id: current_user.id)

    if @reminder.save
      flash[:notice] = 'Reminder created'
      redirect_to admin_reminders_path
    else
      flash[:alert] = 'Reminder create failed'
      render :new
    end
  end

  def edit; end

  def update
    if @reminder.update(reminder_params)
      flash[:notice] = 'Reminder updated'
      redirect_to admin_reminders_path
    else
      flash[:alert] = 'Reminder update failed'
      render :edit
    end
  end

  def destroy
    if @reminder.destroy
      redirect_to admin_reminders_path
    else
      # Message here
      flash[:alert] = 'Reminder destroy failed'
      render :index
    end
  end

  private

  def load_reminder
    @reminder = Reminder.find params[:id]
  end

  def reminder_params
    params.require(:reminder).permit(:title, :content, :hour, :minute, :only_once, day: []).tap do |param|
      param[:day].reject! { |day| day.empty? }
      # Fix this when have time
      if param[:hour].to_i >= 7
        param[:hour] = param[:hour].to_i - 7
      else
        param[:hour] = 24 - (param[:hour].to_i - 7)
      end
    end
  end
end
