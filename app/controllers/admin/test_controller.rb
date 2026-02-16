class Admin::TestController < Admin::AdminController
  def index
    @users = User.all
  end
end
