module Api
  module V1
    class BaseController < ActionController::Base

      # acts_as_token_authenticator_for User

      # serialization_scope :current_user

      rescue_from Koala::Facebook::AuthenticationError do |e|
        CustomLogger.log_400(e.message)
        api_error(:forbidden, BaseApiError.new(e.message, :forbidden))
      end

      # rescue_from TokenAuth::Unauthorized do |e|
      #   CustomLogger.log_400(e.message)
      #   api_error(:unauthorized, BaseApiError.new(e.message, :unauthorized))
      # end

      rescue_from ActiveRecord::RecordNotFound do |e|
        CustomLogger.log_400(e.message)
        api_error(:not_found, BaseApiError.new(e.message))
      end

      rescue_from ActiveRecord::RecordInvalid do |e|
        CustomLogger.log_400(e.message)
        api_error(:unprocessable_entity, ValidationApiError.new(e.record.errors))
      end

      rescue_from CanCan::AccessDenied do |e|
        CustomLogger.log_400(e.message)
        api_error(:forbidden, BaseApiError.new(e.message))
      end

      rescue_from ActionController::ParameterMissing do |e|
        CustomLogger.log_400(e.message)
        api_error(:unprocessable_entity, BaseApiError.new(e.message))
      end

      def api_error(status = :internal_server_error, error)
        Rails.logger.error(error.message)
        render json: error.to_json, status: status
      end

      # def current_user
      #   current_authenticated_entity
      # end

      def render_json(json, status = :ok, serializer = nil)
        if serializer.blank?
          render json: json, status: status
        else
          render json: json, status: status,
          each_serializer: serializer
        end
      end
    end
  end
end
