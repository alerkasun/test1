class Device < ApplicationRecord
  ALLOWED_PLATFORMS = %w(ios android).freeze

  belongs_to :deviceble, polymorphic: true

  validates(
    :device_id,
    presence: true,
    uniqueness: true,
    length: { maximum: 50 }
  )
  validates(
    :platform,
    presence: true,
    inclusion: {
      in: ALLOWED_PLATFORMS,
      message: I18n.t('errors.platform_not_in_scope')
    }
  )

  before_create :enable_device
  scope(
    :push_credentails,
    -> { Device.where(enabled: true).pluck(:platform, :push_token) }
  )

  def enable_device
    self.enabled = true
  end
end
