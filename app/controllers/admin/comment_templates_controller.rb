class Admin::CommentTemplatesController < Admin::AdminController
  include CommentBotModule

  def index
    response = get_comment_templates(params[:page], params[:per_page])
    @comment_templates = response['data']
  end

  def new; end

  def create
    response = create_comment_templates(comment_template_params[:content], comment_template_params[:repository_id])

    if response.code == 201
      flash[:notice] = "Comment template created"
      redirect_to admin_comment_templates_path
    else
      flash[:danger] = "There's error while create comment template"
      render :new
    end
  end

  def edit
    response = get_comment_template(params[:id])
    @comment_template = response['data']
  end

  def update
    response = update_comment_template(params[:id], comment_template_params[:content], comment_template_params[:repository_id])

    if response.code == 200
      flash[:notice] = "Comment template updated"
      redirect_to admin_comment_templates_path
    else
      flash[:danger] = "There's error while update comment template"
      response = get_comment_template(params[:id])
      @comment_template = response['data']
      render :edit
    end
  end

  def destroy
    response = destroy_comment_template(params[:id])
    if response.code == 200
      flash[:notice] = 'Comment template deleted'
    else
      flash[:danger] = "There's error while delete comment template"
    end

    redirect_to admin_comment_templates_path
  end

  private

  def comment_template_params
    params.require(:comment_template).permit(:content, :repository_id)
  end
end
