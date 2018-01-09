require 'etc'

# Change to match your CPU core count
workers Etc.nprocessors

# Min and Max threads per worker
threads 1, 6

app_dir = File.expand_path('../..', __FILE__)
shared_dir = "#{app_dir}/tmp"

daemonize false

# Default to production
rails_env = ENV['RAILS_ENV'] || 'production'
environment rails_env

preload_app!

# Set up socket location
bind "unix://#{shared_dir}/sockets/puma.sock"

# Logging
stdout_redirect "#{app_dir}/log/puma.stdout.log",
                "#{app_dir}/log/puma.stderr.log", true

# Set master PID and state locations
pidfile "#{shared_dir}/pids/puma.pid"
state_path "#{shared_dir}/pids/puma.state"
activate_control_app

before_fork do
  ApplicationRecord.connection_pool.disconnect!
end

on_worker_boot do
  ActiveSupport.on_load(:active_record) do
    ApplicationRecord.establish_connection
  end
end
