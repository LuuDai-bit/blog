class ApplicationMailer < ActionMailer::Base
  default from: "Codedehoc <#{ENV['GMAIL_USERNAME']}>"
  layout 'mailer'
end
