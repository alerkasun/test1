class ConfirmEmail < ContextBase
  attr_reader :token, :listener, :entity

  class BadConfirmationToken < RuntimeError; end

  def initialize(token, listener)
    @token    = token
    @listener = listener
  end

  def perform
    in_context do
      begin
        confirmation_token = find_token(token)
        confirm_email confirmation_token.entity
        confirmation_token.destroy

        listener.confirm_email_success entity
      rescue StandardError => e
        listener.confirm_email_error e
      end
    end
  end

  private

  def confirm_email(entity)
    @entity ||= entity
    @entity.update! email_confirmed: true
  end

  def find_token(token)
    # TokenAuth::ConfirmationToken.find(token)
  end
end
