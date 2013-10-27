class UserMailer < ActionMailer::Base
  default from: 'webmaster@evanamccullough.com'
 
  def welcome_email(user)
    @user = user
    @url  = 'http://gymingit.herokuapp.com/signup'
    mail(to: @user.email, subject: 'Thanks for joining!')
  end

end
