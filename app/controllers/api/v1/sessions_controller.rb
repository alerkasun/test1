module Api
  module V1
    class SessionsController < BaseController
      skip_acts_as_token_authenticator_for User

      def create
        session = User.authenticate(auth_params)
        render json: session, serializer: Api::V1::AuthenticationSerializer
      end

      def auth_params
        [params.require(:email), params.require(:password)]
      end
    end
  end
end
