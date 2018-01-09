module SocialClients
  class Instagram < BaseClient
    def profile_info
      {
        id: raw_profile_info[:id],
        email: raw_profile_info[:email],
        name: raw_profile_info[:full_name]
      }
    end

    def raw_profile_info
      @raw_profile_info ||= @client.user || {}
    end

    private

    def client
      @client ||= Instagram.client(access_token: access_token)
    end
  end
end
