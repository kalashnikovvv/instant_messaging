redis = Redis.current

redis_config = {
  url: "redis://#{redis.client.host}:#{redis.client.port}/#{redis.client.db}",
  namespace: redis.namespace
}

Sidekiq.configure_server do |config|
  config.redis = redis_config
end

Sidekiq.configure_client do |config|
  config.redis = redis_config
end
