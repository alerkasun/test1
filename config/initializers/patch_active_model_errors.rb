require 'active_model/errors'

module ActiveModel
  class Errors
    attr_reader :errors_codes

    def initialize(base)
      @base     = base
      @messages = apply_default_array({})
      @details = apply_default_array({})
      @errors_codes = apply_default_array({})
    end

    def initialize_dup(other) # :nodoc:
      @messages = other.messages.dup
      @details  = other.details.deep_dup
      @errors_codes = other.messages.dup

      super
    end

    alias clear_original clear

    def clear
      clear_original
      errors_codes.clear
    end

    alias add_original add

    def add(attribute, message = :invalid, options = {})
      errors_code = message
      add_original(attribute, message, options)

      add_error_code(attribute, errors_code, message)
    end

    def add_error_code(attribute, code, message)
      @errors_codes[attribute.to_sym] ||= []
      @errors_codes[attribute.to_sym] << {
        code: code,
        description: message
      }
    end
  end
end
