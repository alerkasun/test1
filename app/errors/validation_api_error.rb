class ValidationApiError < ApiError
  def initialize(errors)
    @attributes = errors.messages.each_with_object({}) do |attribute, item|
      attribute[item[0]] = item[1].map { |msg| { message: msg } }
      attribute
    end
  end
end
