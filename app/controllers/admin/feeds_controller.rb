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
end
