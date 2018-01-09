class ResetPassword < ContextBase
  attr_reader :recoverable, :password, :listener

  def initialize(recoverable, password, listener)
    @recoverable = recoverable
    @password    = password
    @listener    = listener
  end

  def perform
    in_context do
      begin
        entity.update! password: password
        recoverable.destroy

        listener.reset_password_on_success
      rescue StandardError => e
        listener.reset_password_on_error e
      end
    end
  end

  private

  def entity
    @entity ||= recoverable.entity
  end
end
