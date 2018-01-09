module Api
  module V1
    class ErrorsExampleController < BaseController
      class CvvInvalid < ApiError; end
      class Appointment < ApiError; end

      def cvv
        raise CvvInvalid
      end

      def appointment
        meta = {
          'available_slots': [
            { 'id': 4, 'name': 'Slot1' },
            { 'id': 5, 'name': 'Slot2' }
          ]
        }
        raise Appointment.new(meta: meta)
      end

      def active_record_invalid
        Device.new.validate!
      end

      def uncovered
        raise 'UncoveredExeption'
      end
    end
  end
end
