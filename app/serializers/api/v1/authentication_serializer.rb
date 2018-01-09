module Api
  module V1
    class AuthenticationSerializer < ::BaseSerializer
      attributes :user, :authentication_token
      # , :exchange_token

      def user
        Api::V1::UserSerializer.new(object.entity, root: false)
      end

      def authentication_token
        object.auth_token
      end

      def exchange_token
        object.exchange_token
      end
    end
  end
end
