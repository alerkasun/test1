class ApplicationMailer < ActionMailer::Base
  layout 'application_mailer'
  default from: Rails.application.config.default_mail_from
end
