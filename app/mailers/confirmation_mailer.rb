class ConfirmationMailer < ApplicationMailer
  def confirm_mail(email, link)
    @link = link
    mail(to: email, subject: 'Confirm email')
  end
end
