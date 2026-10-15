class Admin::DraftPostsController < Admin::AdminController
  skip_before_action :verify_authenticity_token
  before_action :load_draft_post, only: %i[show update destroy]

  def show; end

  def create
    draft_post = DraftPost.new(draft_post_params)

    if draft_post.save
      render json: { message: "Successfully created draft post", draft_post_id: draft_post.id }, status: :created
    else
      error_msg = {
        message: "Failed to create draft post",
        details: draft_post.errors.full_messages
      }

      render json: error_msg, status: :bad_request
    end
  end

  def update
    @draft_post.assign_attributes(draft_post_params)

    if @draft_post.save
      render json: { message: "Successfully updated draft post" }, status: :ok
    else
      error_msg = {
        message: "Failed to create draft post",
        details: @draft_post.errors.full_messages
      }

      render json: error_msg, status: :bad_request
    end
  end

  def destroy
    if @draft_post.destroy
      redirect_to edit_admin_post_path(@draft_post.post_id)
    else
      render json: { message: "Failed to destroy" }, status: :bad_request
    end
  end

  private

  def draft_post_params
    params.require(:draft_post).permit(:subject, :subject_en, :content, :content_en, :post_id)
  end

  def load_draft_post
    @draft_post = DraftPost.find_by_id(params[:id])
  end
end
