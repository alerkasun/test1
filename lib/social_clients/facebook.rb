module SocialClients
  class Facebook < BaseClient
    def profile_info
      {
        id: raw_profile_info['id'],
        email: raw_profile_info['email'],
        first_name: raw_profile_info['first_name'],
        last_name: raw_profile_info['last_name'],
        avatar: raw_profile_info['picture']['data']['url']
      }
    end

    def raw_profile_info
      @raw_profile_info ||= client.get_object(
        'me?fields=id,email,first_name,last_name,picture.type(large)') || {}
    end

    private

    def client
      Koala::Facebook::API.new(access_token)
    end
  end
end
