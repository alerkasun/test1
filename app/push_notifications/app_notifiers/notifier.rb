module AppNotifiers
  class Notifier
    attr_reader :notification
    attr_reader :device
    PROVIDERS = {
      ios: 'Apns',
      android: 'Gcm'
    }.freeze

    def initialize(os)
      provider = PROVIDERS[os.to_sym]
      @notification = "Rpush::#{provider}::Notification".constantize.new
      @notification.app = "Rpush::#{provider}::App".constantize
                                                   .where(name: os).first
    end

    def notify
      return unless notification.device_token
      notification.save!
      device.increment(:badge_count)
    end
  end
end
