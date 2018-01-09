class BaseSerializer < ActiveModel::Serializer
  def format_date_time(date_time)
    date_time.iso8601 if date_time.present?
  end

  def self.date_time(*args)
    args.each { |arg| define_date_time_converter(arg) }
  end

  def self.define_date_time_converter(attribute_name)
    define_method(attribute_name) do
      method_name = __method__
      date_time = object.send method_name

      format_date_time date_time
    end
  end
end
