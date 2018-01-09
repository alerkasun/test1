class CreateUser < ContextBase
  attr_reader :user_params, :user, :listener

  def initialize(user_params, listener)
    @user_params = user_params
    @listener = listener
  end

  def perform
    in_context do
      begin

        @user = User.create_with_profile!(user_params)
                    .extend RegistrationActions

        user.send_confirmation_email

        listener.on_create_user_success user
      rescue StandardError => error
        listener.on_create_user_error error
      end
    end
  end

  module RegistrationActions
    include DCI::ContextAccessor

    def send_confirmation_email
      ConfirmationMailer.confirm_mail(email, link).deliver_later
    end

    private

    def generate_confirmation_token
      confirmation_token = TokenAuth::ConfirmationToken.new(self)
      confirmation_token.generate!
      confirmation_token.token
    end

    def link
      context.listener.confirm_email_by_token_url generate_confirmation_token
    end
  end
end
