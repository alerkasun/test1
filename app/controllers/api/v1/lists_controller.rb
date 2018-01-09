module Api
  module V1
    class ListsController < BaseController
      # skip_acts_as_token_authenticator_for User

      before_action :find_list, only: [:update, :show]
      def create
        render_json List.create! list_params
      end

      def update
        @prayer.update! list_params
        render_json @prayer
      end

      def show
        if params[:user_id].present?
          List.where(user_id: params[:user_id]).find(params[:id])
        else
          @prayer = List.find(params[:id])
        end

        render_json @prayer
      end

      def index

        prayer = List.where(is_published: false)
          .where(is_free: true)
          .order(created_at: :desc)
          .page(params[:page])
          .per(params[:per_page])

          # render_json Api::V1::PrayerSerializer.new(@prayer)
          render_json prayer, :ok, Api::V1::ListSerializer
      end

      def list_params
        params.permit(:text, :description, :is_free, :is_published, :user_id)
      end

      def find_list
        @prayer = List.find(params[:id])
      end
    end
  end
end
