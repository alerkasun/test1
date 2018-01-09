class CustomLogger
  def self.log_400(message = nil)
    @log400 ||= Logger.new("#{Rails.root}/log/400.log")
    @log400.debug(message) unless message.nil?
  end
end
