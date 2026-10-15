class Admin::DraftPostsController < Admin::AdminController
  skip_before_action :verify_authenticity_token
  before_action :load_draft_post, only: %i[show update destroy apply]

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
      render :show
    end
  end

  # Copy content of this draft post to original post and destroy draft post
  def apply
    original_post = @draft_post.post
    original_post.subject = @draft_post.subject
    original_post.subject_en = @draft_post.subject_en
    original_post.content = @draft_post.content
    original_post.content_en = @draft_post.content_en

    if original_post.save
      redirect_to edit_admin_post_path(original_post)
    else
      render :show
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
