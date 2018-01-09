module Api
  module V1
    class PaymentsController < BaseController
      before_action :find_payer

      def create
        Payments::CreatePayment.perform(@payer, payment_params.to_h, self)
      end

      def confirm_payment_success(charge)
        render json: charge
      end

      def confirm_payment_error(error)
        raise error
      end

      private

      def payment_params
        params.permit(
          :token, :card, :amount, :currency, :description,
          destinations: [
            { recipient: [:type, :id] },
            :amount,
            :application_fee
          ]
        )
      end

      def find_payer
        @payer = User.find(params[:user_id])
      end
    end
  end
end
