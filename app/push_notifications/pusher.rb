class Pusher
  attr_reader :device, :push_body

  def initialize(device, message, options = {})
    @device = device
    @push_body = options.merge message
  end

  def notify
    return unless device.enabled?
    notifier_name(device.platform).new(device, push_body).notify
  end

  private

  def notifier_name(app_name)
    "AppNotifiers::#{app_name.capitalize}Notifier".constantize
  end
end
