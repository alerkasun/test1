module SocialClients
  class BaseClient
    attr_reader :access_token

    def initialize(access_token)
      @access_token = access_token
    end
  end
end
