# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Eventer::Application.initialize!

#ActionMailer configuration
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address => "smtp.gmail.com",
  :port => 587,
  :domain => "eventos.kleer@kleer.la",
  :user_name => ENV["KEVENTER_GMAIL_USERNAME"],
  :password => ENV["KEVENTER_GMAIL_PASSWORD"],
  :authentication => "plain",
  :enable_starttls_auto => true
}
