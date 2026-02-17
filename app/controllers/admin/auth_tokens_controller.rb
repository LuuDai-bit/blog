class Admin::AuthTokensController < Admin::AdminController
  def index
    @pagy, @auth_tokens = pagy(AuthToken.order(id: :desc))
    @auth_tokens.map(&:mask)
  end

  def create
    @auth_token = AuthToken.new
    @auth_token.token = SecureRandom.uuid

    if @auth_token.save
      flash.now[:notice] = 'Authentication token created'

      redirect_to admin_auth_tokens_path
    else
      flash.now[:alert] = 'Error occurs while creating authentication token'

      render :index
    end
  end

  def show
    @auth_token = AuthToken.find_by(id: params[:id])
  end

  def destroy
    @auth_token = AuthToken.find(params[:id])

    if @auth_token.destroy
      flash.now[:notice] = 'Authentication token deleted'

      redirect_to admin_auth_tokens_path
    else
      flash.now[:alert] = 'Error occurs while delete authentication token'

      render :index
    end
  end
end
