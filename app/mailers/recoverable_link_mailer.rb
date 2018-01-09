class RecoverableLinkMailer < ApplicationMailer
  def reset_password_mail(email, link)
    @link = link
    mail(to: email, subject: subject)
  end

  def subject
    [Rails.application.config.application_title, 'reset password'].join(' ')
  end
end
