module AppNotifiers
  class IosNotifier < Notifier
    def initialize(device, body)
      super 'ios'

      @device = device
      notification.badge = device.badge_count
      notification.device_token = device.push_token
      notification.alert = body[:message]
      notification.data = body.except(:message)
    end
  end
end
