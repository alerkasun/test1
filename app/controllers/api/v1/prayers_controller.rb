module Api
  module V1
    class PrayersController < BaseController
      # skip_acts_as_token_authenticator_for User

      before_action :find_prayer, only: [:update, :show, :destroy]

      def create
        render_json Prayer.create! prayer_params
      end

      def update
        @prayer.update! prayer_params
        render_json @prayer
      end

      def show
        if params[:user_id].present?
          Prayer.where(user_id: params[:user_id]).find(params[:id])
        else
          @prayer = Prayer.find(params[:id])
        end

        render_json @prayer
      end

      def index
        prayer = Prayer.where(is_published: false)
          .where(is_free: true)
          .order(created_at: :desc)
          .page(params[:page])
          .per(params[:per_page])

        render_json prayer, :ok, Api::V1::PrayerSerializer
      end

      def destroy
        @prayer.archive!
        render_json nil, :no_content
      end

      def prayer_params
        params.permit(:text, :description, :is_free, :is_published, :user_id)
      end

      def find_prayer
        @prayer = Prayer.find(params[:id])
      end
    end
  end
end
