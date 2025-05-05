class Admin::PasswordsController < Admin::AdminController
  def edit; end

  def update
    @user = ::Admin::PasswordForm.new(password_params.merge(id: params[:id]))
    if @user.save
      flash[:notice] = 'Password updated'
      redirect_to admin_posts_path
    else
      flash[:alert] = 'Password update failed'
      render :edit
    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
