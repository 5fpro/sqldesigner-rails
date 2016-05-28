Sidekiq.configure_server do |config|
  config.redis = Setting.sidekiq.symbolize_keys
end

# When in Unicorn, this block needs to go in unicorn's `after_fork` callback:
Sidekiq.configure_client do |config|
  config.redis = Setting.sidekiq.symbolize_keys
end
