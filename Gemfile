source 'https://rubygems.org'

ruby '2.3.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.0'

# Use postgresql as the database for Active Record
gem 'pg'

# https://github.com/errbit/errbit for errors

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'rack-timeout'
gem 'active_model_serializers', '0.9.4'
gem 'oj'
gem 'kaminari'
gem 'dci', github: 'techery/dci'
gem 'puma'
gem 'redis'
gem 'versionist'
gem 'uglifier'


gem 'simple_token_authentication', '~> 1.0'

gem 'activeadmin', '~> 1.0.0.pre4'
gem 'inherited_resources', github: 'activeadmin/inherited_resources'
gem 'sass-rails'
gem 'cancancan'
gem 'devise'
gem 'validates_timeliness', '~> 3.0'
gem 'carrierwave'
gem 'mini_magick'
gem 'rpush'
gem 'dotenv-rails'
gem 'foreman', require: false
gem 'sidekiq'
gem 'bootstrap-sass', '~> 3.3.6'
gem 'koala', '~> 2.2'
gem 'virtus'
gem 'httparty'
gem 'twitter'
gem 'instagram'

group :development do
  gem 'web-console', '~> 2.0'

  gem 'highline'
  gem 'capistrano', '~> 3.1', require: false
  gem 'capistrano-rails', '~> 1.1', require: false
  gem 'capistrano-rvm', require: false
  gem 'capistrano-bundler', '~> 1.1.2', require: false
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get
  # a debugger console
  gem 'byebug'
  gem 'factory_girl_rails'
  gem 'ffaker'
  gem 'faker'
  gem 'awesome_print'
  gem 'rspec-rails', '~> 3.1'
  gem 'rspec-collection_matchers'
  gem 'rspec_api_documentation'
  gem 'rubocop', require: false
end

group :test do
  gem 'database_cleaner'
  gem 'shoulda-matchers', '~> 2.8.0', require: false
  gem 'simplecov', require: false
  gem 'timecop'
  gem 'webmock'
  gem 'rails-controller-testing'
end

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
