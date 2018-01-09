module SocialClients
  class Factory
    def self.create(provider, access_token, access_secret = nil)
      case provider.to_sym
      when :facebook
        SocialClients::Facebook.new(access_token)
      when :google
        SocialClients::Google.new(access_token)
      when :twitter
        SocialClients::Twitter.new(access_token, access_secret)
      when :instagram
        SocialClients::Instagram.new(access_token)
      end
    end
  end
end
