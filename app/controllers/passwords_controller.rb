class PasswordsController < ActionController::Base
  before_action { flash.clear }
  before_action :recoverable_token
  before_action :validate_password, only: [:update]

  # rescue_from TokenAuth::FindEntityException do
  #   render file: "#{Rails.root}/public/404.html", layout: false,
  #          status: :not_found
  # end

  def edit
    @reset_password = ResetPasswordForm.new
  end

  def update
    ResetPassword.perform(*reset_password_params)
  end

  def reset_password_on_success
    flash[:notice] = success_message
    render :index
  end

  def reset_password_on_error(error)
    raise error
  end

  private

  def validate_password
    @reset_password = ResetPasswordForm.new password_attributes
    render action: :edit unless @reset_password.valid?
  end

  def password_attributes
    params.require(:reset_password_form).permit(:password,
                                                :password_confirmation).to_h
  end

  def reset_password_params
    [recoverable_token, params[:reset_password_form][:password], self]
  end

  def success_message
    I18n.t 'reset_password.your_password_has_been_successfully_changed'
  end

  def recoverable_token
    # @recoverable_token ||= TokenAuth::PasswordRecoveryToken.find(params[:token])
  end
end
