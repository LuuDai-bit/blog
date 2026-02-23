class Admin::CommentTemplatesController < Admin::AdminController
  include CommentBotModule

  def index
    response = get_comment_templates(params[:page], params[:per_page])
    @comment_template = response['data']
  end

  def new; end

  def create
  end

  def edit; end

  def update
  end

  def destroy
  end
end