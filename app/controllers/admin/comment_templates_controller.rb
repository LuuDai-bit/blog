class Admin::CommentTemplatesController < Admin::AdminController
  before_action :load_repositories, only: %i[new edit create update]

  include CommentBotModule

  def index
    response = get_comment_templates(params[:page], params[:per_page])
    @comment_templates = response['data']
    # TODO: Pagination
  end

  def new; end

  def create
    @response = create_comment_templates(comment_template_params[:content],
                                         comment_template_params[:repository_id],
                                         comment_template_params[:status])

    if @response.code == 201
      flash[:notice] = "Comment template created"
      redirect_to admin_comment_templates_path
    else
      flash.now[:alert] = "There is error while create comment template"
      render :new
    end
  end

  def edit
    response = get_comment_template(params[:id])
    @comment_template = response['data']
  end

  def update
    @response = update_comment_template(params[:id],
                                        comment_template_params[:content],
                                        comment_template_params[:repository_id],
                                        comment_template_params[:status])

    if @response.code == 200
      flash[:notice] = "Comment template updated"
      redirect_to admin_comment_templates_path
    else
      flash.now[:alert] = "There is error while update comment template"
      comment_template_response = get_comment_template(params[:id])
      @comment_template = comment_template_response['data']
      render :edit
    end
  end

  def destroy
    response = destroy_comment_template(params[:id])
    if response.code == 200
      flash[:notice] = 'Comment template deleted'
    else
      flash.now[:alert] = "There is error while delete comment template"
    end

    redirect_to admin_comment_templates_path
  end

  def make_active
    response = mark_comment_template_as_active(params[:id])
    if response.code == 200
      flash[:notice] = 'Comment template marked as active'
    else
      flash.now[:alert] = "There is error while marking comment template as active"
    end

    redirect_to admin_comment_templates_path
  end

  private

  def comment_template_params
    params.require(:comment_template).permit(:content, :repository_id, :status)
  end

  def load_repositories
    response = get_repositories
    @repositories = response['data']
  end
end
