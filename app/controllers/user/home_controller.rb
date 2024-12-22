class User::HomeController < User::UserController
  def about
    @about_me = AboutMe.first_or_create
  end

  def contact; end
end
