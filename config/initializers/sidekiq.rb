redis_url = [
  'redis://', ENV['REDIS_HOST'], ':', ENV['REDIS_PORT'], '/', ENV['REDIS_INDEX']
]

block = proc { |config| config.redis = { url: redis_url.join('') } }

Sidekiq.configure_server(&block)
Sidekiq.configure_client(&block)
