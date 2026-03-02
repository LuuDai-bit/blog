class Admin::RepositoriesController < Admin::AdminController
  include CommentBotModule

  def create
    response = create_respository(repository_params[:owner], repository_params[:name])

    if response.code == 201
      render json: { data: response }
    else
      render json: { data: response }, status: :unprocessable_entity
    end
  end

  private

  def repository_params
    params.require(:repository).permit(:owner, :name)
  end
end
