class Admin::FeedsController < Admin::AdminController
  def index
    @page = params[:page] ? params[:page].to_i : 1
    @per_page = params[:per] ? params[:per].to_i : 20
    @feeds = ::Feed.list_with_pagination(@page, @per_page)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def mark_as_read
    result = ::Feed.mark_as_read(params[:id].to_i)

    if result.code == 200
      render json: { message: "Success" }
    else
      render json: { message: "Failed" }, status: :bad_request
    end
  end
end
