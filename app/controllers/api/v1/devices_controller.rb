module Api
  module V1
    class DevicesController < BaseController
      acts_as_token_authenticator_for User

      def create
        current_session.entity.attach_device device_params
        render json: current_session.entity
      end

      def device_params
        params.permit(:device_id, :push_token, :platform)
      end
    end
  end
end
