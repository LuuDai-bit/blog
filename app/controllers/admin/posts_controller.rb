class Admin::PostsController < Admin::AdminController
  before_action :load_post, only: %i[show edit update destroy]

  def index
    @pagy, @posts = pagy(Post.order_by_status(params[:order_views])
                             .order_by_views(params[:order_views])
                             .by_subject(params[:search_text])
                             .includes(:author))
  end

  def show; end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new post_params

    if @post.save
      flash[:notice] = 'Post created'
      redirect_to admin_posts_path
    else
      flash[:alert] = 'Post create failed'
      render :new
    end
  end

  def edit; end

  def update
    if UpdatePostService.run(@post, post_params)
      flash[:notice] = 'Post updated'
      redirect_to admin_posts_path
    else
      flash[:alert] = 'Post update failed'
      render :edit
    end
  end

  def destroy
    if @post.destroy
      redirect_to admin_posts_path
    else
      # Message here
      flash[:alert] = 'Post destroy failed'
      render :index
    end
  end

  private

  def load_post
    @post = Post.find params[:id]
  end

  def post_params
    params.require(:post).permit(:subject, :content, :status).merge(user_id: current_user.id)
  end
end
