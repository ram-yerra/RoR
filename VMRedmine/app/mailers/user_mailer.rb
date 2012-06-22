class UserMailer < ActionMailer::Base
  default :from => "vmoksha.test@gmail.com"
 
  def welcome_email(user)
    puts "Welcome email"
    puts user
    @user = user
    @url  = "http://localhost:3000/users"
    mail(:to => user.email, :subject => "Welcome to VM REDMINE")
  end
  
  def welcome_email_test(user)
    puts "Welcome email"
    puts user
    @user = user
    @url  = "http://localhost:3000/users"
    mail(:to => user, :subject => "Welcome to VM REDMINE")
  end
end
