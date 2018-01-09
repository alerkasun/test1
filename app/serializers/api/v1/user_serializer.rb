module Api
  module V1
    class UserSerializer < ::BaseSerializer
      attributes :id, :email, :first_name, :last_name, :avatar

      def avatar
        object.avatar.serializable_hash
      end
    end
  end
end
