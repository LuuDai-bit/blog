class Admin::UsersController < Admin::AdminController
  before_action :load_user, only: %i[show edit udpate]

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      flash[:notice] = 'User created'
      redirect_to root_path
    else
      flash[:alert] = 'User create failed'
      render :new
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def load_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(User::USER_WHITELIST_ATTRIBUTES)
  end
end
