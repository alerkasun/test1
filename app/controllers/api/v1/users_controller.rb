module Api
  module V1
    class UsersController < BaseController
      before_action :find_user, only: [:show]

      def create
        CreateUser.perform user_params, self
      end

      def on_create_user_success(user)
        render json: user
      end

      def on_create_user_error(error)
        raise error
      end

      def show
        render json: @user
      end

      def reset_password
        user = User.find_by! email: params[:email]
        RecoverPassword.perform user, self
      end

      def recover_password_success
        head :no_content
      end

      def recover_password_error(error)
        raise error
      end

      private

      def user_params
        params.permit(:email, :password)
      end

      def find_user
        @user = User.find(params[:id])
      end
    end
  end
end
