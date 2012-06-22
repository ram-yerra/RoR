# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Vmredmine::Application.initialize!

Vmredmine::Application.configure do
  
  config.action_mailer.delivery_method = :smtp 
     
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true

  ActionMailer::Base.smtp_settings = {
    :address              => "smtp.gmail.com",
    :port                 => 587,
    :user_name            => "vmoksha.test@gmail.com",
    :password             => 'Android@123',
    :authentication       => "plain",
    :enable_starttls_auto => true
  }
  
end
