class Admin::RemindersController < Admin::AdminController
  before_action :load_reminder, only: %i(edit update destroy)

  def index
    @pagy, @reminders = pagy(Reminder.order(:id))
  end

  def new
    @reminder = Reminder.new(target_date: Time.current.beginning_of_day, original_timezone: -1)
  end

  def create
    @reminder = Reminder.new reminder_params
    @reminder.user_reminders.build(user_id: current_user.id)

    if @reminder.save
      flash[:notice] = 'Reminder created'
      redirect_to admin_reminders_path
    else
      flash.now[:alert] = 'Reminder create failed'
      render :new
    end
  end

  def edit
  end

  def update
    if @reminder.update(reminder_params)
      flash[:notice] = 'Reminder updated'
      redirect_to admin_reminders_path
    else
      flash.now[:alert] = 'Reminder update failed'
      render :edit
    end
  end

  def destroy
    if @reminder.destroy
      redirect_to admin_reminders_path
    else
      flash.now[:alert] = 'Reminder destroy failed'
      render :index
    end
  end

  private

  def load_reminder
    @reminder = Reminder.find params[:id]
  end

  def reminder_params
    original_timezone = params[:reminder][:original_timezone].to_i
    params.require(:reminder).permit(:title, :content, :hour, :minute, :only_once, :original_timezone, day: []).tap do |param|
      param[:target_date] = Time.current
                                .in_time_zone(original_timezone)
                                .beginning_of_day
                                .since(param[:hour].to_i.hour)
                                .since(param[:minute].to_i.minute)

      param[:day].reject! { |day| day.empty? }
      param[:day] = param[:day].map do |day|
                      Settings.models.reminder.day.send("#{day}")
                    end.flatten.uniq
    end.except(:hour, :minute)
  end
end
