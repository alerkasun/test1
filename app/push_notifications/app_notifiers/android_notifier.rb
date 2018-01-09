module AppNotifiers
  class AndroidNotifier < Notifier
    def initialize(token, body)
      super 'android'

      notification.registration_ids = [token]
      notification.data = body
    end
  end
end
