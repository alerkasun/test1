module Api
  module V1
    class ProfileController < BaseController
      acts_as_token_authenticator_for User

      def show
        render json: current_authenticated_entity
      end

      def update
        current_authenticated_entity.profile.edit! profile_params
        render json: current_authenticated_entity, status: :accepted
      end

      private

      def profile_params
        params.permit(:first_name, :last_name, :avatar)
      end
    end
  end
end
