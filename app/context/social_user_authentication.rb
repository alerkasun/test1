class SocialUserAuthentication < ContextBase
  attr_reader :provider, :oauth_token, :oauth_secret, :profile, :client, :listener

  def initialize(provider, oauth_token, oauth_secret = nil, listener)
    @provider = provider
    @listener = listener
    @oauth_token = oauth_token
    @oauth_secret = oauth_secret
    @profile = SocialProfile.new.extend(Authentication)
    @client = SocialClients::Factory.create(provider, oauth_token, oauth_secret)
  end

  def perform
    in_context do
      user_profile = profile.find_or_create
      session = user_profile.user.create_authentication
      listener.create_authentication_on_success(session)
    end
  end

  module Authentication
    include DCI::ContextAccessor

    def find_or_create
      graf_profile = context.client.profile_info
      profile = SocialProfile.find_or_create_by(provider: context.provider, social_id: graf_profile.delete(:id))

      if (profile.user.blank?)
        user = User.find_by(email: graf_profile[:email]) if graf_profile[:email]
        user ||= User.create_with_profile!(graf_profile)
        profile.assign_attributes(user_id: user.id)
      end

      profile.assign_attributes(access_token: context.oauth_token, access_secret: context.oauth_secret)
      profile.save!

      profile
    end
  end
end
