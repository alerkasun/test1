class RecoverPassword < ContextBase
  attr_reader :entity, :recover, :controller

  def initialize(entity, controller)
    @entity     = entity
    @controller = controller
  end

  def perform
    in_context do
      begin
        # @recover = TokenAuth::PasswordRecoveryToken.new entity
        @recover.generate!

        send_mail

        controller.recover_password_success
      rescue StandardError => e
        controller.recover_password_error e
      end
    end
  end

  private

  def send_mail
    RecoverableLinkMailer
      .reset_password_mail(entity.email, generate_link)
      .deliver_later
  end

  def generate_link
    controller.url_for(default_link_params.merge(token: recover.token))
  end

  def default_link_params
    {
      controller: '/passwords',
      action: :edit
    }
  end
end
