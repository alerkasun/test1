class ApiError < StandardError

  attr_reader :meta

  def initialize(meta: {})
    @meta = meta
  end

  def serialize
    errors = instance_variables.inject({}) do |errors, var|
      errors[var.to_s.gsub(/@/, '')] = instance_variable_get(var)
      errors
    end

    { errors: errors }
  end
end
