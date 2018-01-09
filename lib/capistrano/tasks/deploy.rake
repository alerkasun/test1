require 'erb'
require 'foreman'

namespace :deploy do
  desc 'Set up application'
  task :setup do
    dotenv = ["RAILS_ENV=#{fetch(:rails_env)}"]

    File.read('.env.sample').each_line.map do |line|
      key   = line.split('=')[0]
      value = line.split('=')[1]
      ask(key, (value != "\n" ? value : ''))

      dotenv << "#{key}=#{fetch(key)}" if key != "\n" && fetch(key) != ''
    end

    on roles(:app) do
      execute "mkdir -p #{shared_path}"
      upload! StringIO.new(dotenv.join("\n")), "#{shared_path}/.env"
    end
  end

  desc 'Create puma socket file'
  task :create_puma_socket do
    on roles(:web) do
      execute "mkdir -p #{shared_path}/tmp/sockets"
      execute "touch #{shared_path}/tmp/sockets/puma.sock"
    end
  end

  desc 'Configure nginx'
  task :config_nginx do
    file_path  = 'upstart/nginx.conf.erb'
    nginx_path = '/etc/nginx'

    file = fetch(:application)
    nginx_conf = ERB.new(File.read(file_path))

    ask :upstream, ''
    ask :server_name, ''

    upstream = fetch :upstream
    server_name = fetch :server_name

    on roles(:web) do
      within shared_path do
        with rails_env: fetch(:rails_env) do
          upload!(
            StringIO.new(nginx_conf.result(binding)),
            "#{shared_path}/#{file}.conf"
          )

          sudo "mv #{shared_path}/#{file}.conf " \
          "#{nginx_path}/conf.d/#{file}.conf"

          # sudo "rm -f #{nginx_path}/conf.d/#{file}.conf"
          # sudo "ln -s #{nginx_path}/conf.d/#{file}.conf" \
          # " #{nginx_path}/conf.d/#{file}.conf"

          sudo 'service nginx reload'
        end
      end
    end
  end

  desc 'Foreman init'
  task :foreman_init do
    on roles(:all) do
      foreman_temp = "#{shared_path}/foreman_temp"

      execute "mkdir -p #{foreman_temp}"
      execute "ln -s #{release_path} #{current_path}"

      within current_path do
        exec_command = "exec foreman export upstart #{foreman_temp}" \
                       " -a #{fetch(:application)} -u `whoami` -d" \
                       " #{current_path}"
        execute :bundle, exec_command
      end

      sudo "mv #{foreman_temp}/* /etc/init/"
      sudo "rm -r #{foreman_temp}"
    end
  end

  desc 'Upload rpush upstart'
  task :upload_rpush_upstart do
    on roles :all do
      file_path  = 'upstart/rpush.conf.erb'
      rpush_conf = ERB.new(File.read(file_path))

      within shared_path do
        with rails_env: fetch(:rails_env) do
          user        = fetch :user
          application = fetch :application
          rails_env   = fetch :rails_env

          upload!(
            StringIO.new(rpush_conf.result(binding)),
            "#{shared_path}/#{application}-rpush.conf"
          )

          sudo "mv #{shared_path}/#{application}-rpush.conf" \
          " /etc/init/#{application}-rpush.conf"
        end
      end
    end
  end

  desc 'Create database'
  task :setup_db do
    on roles(:db) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'db:setup'
        end
      end
    end
  end

  before :setup, 'deploy:create_puma_socket'
  after  :setup, 'deploy:starting'
  after  :setup, 'deploy:updating'
  after  :setup, 'deploy:config_nginx'
  after  :setup, 'bundler:install'
  after  :setup, 'deploy:setup_db'
  after  :setup, 'deploy:compile_assets'
  after  :setup, 'deploy:foreman_init'
  after  :setup, 'deploy:upload_rpush_upstart'
  after  :setup, 'app:start'
end
