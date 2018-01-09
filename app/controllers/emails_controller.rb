class EmailsController < ActionController::Base
  def confirm
    ConfirmEmail.perform(params[:token], self)
  end

  def confirm_email_success(user)
    @user = user
  end

  def confirm_email_error(error)
    raise ActionController::RoutingError.new(error.message)
  end
end
