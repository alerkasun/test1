module SocialClients
  class Google < BaseClient
    def profile_info
      {
        id: raw_profile_info['id'],
        email: raw_profile_info['email'],
        first_name: raw_profile_info['given_name'],
        last_name: raw_profile_info['family_name'],
        avatar: raw_profile_info['picture']
      }
    end

    def raw_profile_info
      @raw_profile_info ||= client.parsed_response || {}
    end

    def profile_info_url
      'https://www.googleapis.com/oauth2/v1/userinfo?' \
      "alt=json&access_token=#{access_token}"
    end

    private

    def client
      @client = HTTParty.get(profile_info_url)
    end
  end
end
