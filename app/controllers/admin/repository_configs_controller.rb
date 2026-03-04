class Admin::RepositoryConfigsController < Admin::AdminController
  include CommentBotModule

  def index
    if params[:page].blank?
      params[:page] = 1
      params[:per_page] = 20
    end

    response = get_repositories_with_pagination(params[:page], params[:per_page])
    @repositories = response['data']
    pagination = response['meta']
    @pagy = Pagy.new(count: pagination['total_count'],
                     page: pagination['page'],
                     items: pagination['per_page'])
  end

  def edit
    @repository = get_repository(params[:id])['data']
  end
end
