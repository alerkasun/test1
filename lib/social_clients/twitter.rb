class SocialClients::Twitter < SocialClients::BaseClient
  attr_reader :access_secret

  def initialize(access_token, access_secret)
    super(access_token)
    @access_secret = access_secret
  end

  def profile_info
    {
      id: raw_profile_info[:id],
      email: raw_profile_info[:email],
      last_name: raw_profile_info[:name].split(" ").first,
      first_name: raw_profile_info[:name].split(" ").last
    }
  end

  def raw_profile_info
    @raw_profile_info ||= client.user.to_hash || {}
  end

  private

  def client
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token        = access_token
      config.access_token_secret = access_secret
    end
  end
end
