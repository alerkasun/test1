ActionMailer::Base.smtp_settings = {
  address:            ENV['SMTP_ADDRESS'],
  port:               ENV['SMTP_PORT'],
  user_name:          ENV['SMTP_USERNAME'],
  password:           ENV['SMTP_PASSWORD'],
  domain:             ENV['SMTP_DOMAIN'],
  authentication:     :plain,
  enable_starttls_auto: true
}
