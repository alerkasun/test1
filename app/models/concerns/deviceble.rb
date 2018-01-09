module Deviceble
  extend ActiveSupport::Concern

  included do
    has_many :devices, as: :deviceble
    delegate :device_id, :push_token, :platform, to: :device
  end

  def attach_device(params)
    @device = devices.find_or_initialize_by(device_id: params[:device_id])
    @device.update_attributes!(
      push_token: params[:push_token],
      platform: params[:platform],
      deviceble_id: id,
      deviceble_type: self.class.name
    )
  end
end
