class TestSesMailer < ApplicationMailer
  def welcome_email
    @user = User.first
    @url  = 'http://example.com/login'
    mail(to: "dailx087@gmail.com", subject: 'Welcome to My Awesome Site')
  end
end
