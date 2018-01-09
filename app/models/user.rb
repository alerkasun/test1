class User < ApplicationRecord
  include ::Profileable
  include ::Deviceble
# acts_as_token_authenticatable
  has_many :prayers

  validates :email, uniqueness: true, allow_nil: true

  # credentials :email, :password
end
