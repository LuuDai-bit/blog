class Admin::UsersController < ApplicationController
  before_action :load_user, only: %i[show edit udpate]

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save!
      redirect_to root_path
    else
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
