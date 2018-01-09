Rack::Timeout.timeout = if Rails.env.production?
                          ENV['RACK_TIMEOUT'] || 5
                        else
                          false
                        end
