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
    response = create_variable(variable_params[:name], variable_params[:format])

    if response.code == 201
      render json: { data: response }
    else
      render json: { error: response }, status: :unprocessable_entity
    end
  end

  def update
    response = update_variable(params[:id], variable_params[:name], variable_params[:format])

    if response.code == 200
      render json: { data: response }
    else
      render json: { error: response }, status: :unprocessable_entity
    end
  end

  def destroy
    response = destroy_variable(params[:id])

    if response.code == 200
      render json: { data: response }
    else
      render json: { error: response }, status: :unprocessable_entity
    end
  end

  private

  def variable_params
    params.require(:variable).permit(:name, :format)
  end
end
