class SocialAuthenticationForm < FormBase
  validates :oauth_token, presence: true
  attribute :oauth_token, String

  validates :provider, presence: true
  attribute :provider, String
end
