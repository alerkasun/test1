module Api
  module V1
    class PaymentsAccountsController < BaseController
      before_action :find_user, only: [:create]
      before_action :find_account, only: [:show, :update]

      def create
        account = @user.create_payments_account(account_params)
        render json: account
      end

      def show
        render json: @account
      end

      private

      def account_params
        params.permit(:email, :country)
      end

      def find_user
        @user = User.find(params[:user_id])
      end

      def find_account
        @account = Payments::Account.find(params[:id])
      end
    end
  end
end
