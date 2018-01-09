class SocialProfile < ApplicationRecord
  belongs_to :user

  validates_presence_of :social_id, :provider
  validates_uniqueness_of :social_id, scope: :provider
end
