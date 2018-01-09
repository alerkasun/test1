# config valid only for current version of Capistrano
lock '3.6.0'

set :application, 'prayer_app'
set :repo_url, 'git@bitbucket.org:ikoryakin/prayerback.git'
# set :repo_url, 'https://vsan2017@bitbucket.org/ikoryakin/prayerback.git'


# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: 'log/capistrano.log',
# color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

set :rvm_ruby_version, '2.3.0@prayer-app'

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('.env')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push(
  'public/uploads',
  'tmp/pids',
  'tmp/cache',
  'tmp/sockets',
  'log'
)

after 'deploy:finishing', 'app:restart'

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5
