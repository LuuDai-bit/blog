class Admin::VariablesController < Admin::AdminController
  include CommentBotModule

  def index
    response = get_variables(params[:repository_id])
    @variables = response['data']

    if response.code == 200
      json = {
        data: render_to_string(partial: 'admin/comment_templates/variables',
                               layout: false,
                               formats: [:html] )
      }
      render json: json
    else
      render json: { error: response }, status: :unprocessable_entity
    end
  end

  def create
    response = create_variable(variable_params)

    if response.code == 201
      @repository = get_repository(variable_params[:repository_id])['data']
      html = {
        data: render_to_string(partial: 'admin/repository_configs/variable',
                               layout: false,
                               formats: [:html],
                               collection: @repository.try(:[], 'variables') )
      }
      render json: html
    else
      render json: { error: response }, status: :unprocessable_entity
    end
  end

  def update
    response = update_variable(params[:id], variable_params)

    if response.code == 200
      @repository = get_repository(variable_params[:repository_id])['data']
      html = {
        data: render_to_string(partial: 'admin/repository_configs/variable',
                               layout: false,
                               formats: [:html],
                               collection: @repository.try(:[], 'variables') )
      }
      render json: html
    else
      render json: { error: response }, status: :unprocessable_entity
    end
  end

  def destroy
    response = destroy_variable(params[:id])

    if response.code == 200
      @repository = get_repository(params[:repository_id])['data']
      html = {
        data: render_to_string(partial: 'admin/repository_configs/variable',
                               layout: false,
                               formats: [:html],
                               collection: @repository.try(:[], 'variables') )
      }
      render json: html
    else
      render json: { error: response }, status: :unprocessable_entity
    end
  end

  private

  def variable_params
    params.require(:variable).permit(:name, :format, :repository_id, :variable_type,
                                     :boolean_false_message, :boolean_success_message)
  end
end
