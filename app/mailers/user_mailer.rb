class UserMailer < ActionMailer::Base
  default from: 'notifications@pipecast.in'
 
  def welcome_email(user)
    @user = user
    @url  = 'http://pipecast.in'
    mail(to: @user.email_id, subject: 'Welcome to My Awesome Site')
  end
end