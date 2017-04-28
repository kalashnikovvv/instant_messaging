if Rails.env.test?
  redis = MockRedis.new
else
  redis = Redis.new(host: ENV['REDIS_HOST'], port: ENV['REDIS_PORT'], db: ENV['REDIS_DB'])
end

Redis.current = Redis::Namespace.new("#{ENV['REDIS_NAMESPACE']}-#{Rails.env}", redis: redis)
