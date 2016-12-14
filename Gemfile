source 'https://rubygems.org'
gem 'rails', '~> 5.0.0', '>= 5.0.0.1'

# DB
gem 'pg'
gem 'activerecord-postgis-adapter'
gem 'redis'
gem 'redis-objects', require: 'redis/objects'

# stores
gem 'dalli'
gem 'connection_pool'

# ENV
gem 'settingslogic'

# view rendering
gem 'jbuilder', '~> 2.0'
gem 'slim'
gem 'simple_form'
gem 'nested_form'

# assets
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'asset_sync'

# JS plugin
gem 'jquery-rails'
gem 'select2-rails', '~> 3'
gem 'turbolinks', '~> 5'

# background jobs
gem 'sidekiq'
gem 'sinatra', '~> 2.0.0.beta2'
gem 'sidekiq-limit_fetch'

# file upload
gem 'carrierwave'
gem 'mini_magick'
gem 'fog'
gem 'carrierwave_backgrounder'

# soft delete
gem 'paranoia'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
group :staging, :production do
  gem 'newrelic_rpm'
end

group :development do
  # capistrano
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
  gem 'capistrano-sidekiq'
  # unicorn
  gem 'capistrano3-unicorn'
  # slack
  gem 'slackistrano', require: false

  gem 'annotate'
  gem 'xray-rails'
  gem 'http_logger'
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  gem 'rubocop'

  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # rename app name
  # gem 'rails-rename'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'byebug'
end

group :test do
  gem 'webmock'
  gem 'timecop'
  gem 'database_cleaner'
end

group :doc do
  gem 'sdoc', '~> 0.4.0'
end

gem 'rollbar'
gem 'kaminari'

# devise
gem 'devise'

# aws
gem 'aws-sdk-v1'
gem 'aws-sdk'

# unicorn
gem 'unicorn'

# versioning
gem 'paper_trail'

gem 'slack-notifier'
gem 'acts-as-taggable-on'
gem 'ransack'

# model sorting
gem 'acts_as_list'

# omniauth
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-github'
gem 'omniauth-google-oauth2'
gem 'omniauth-oauth2'

# front-end
gem 'jquery-ui-rails'
gem 'bootstrap-sass'

# SEO
gem 'crummy'
gem 'meta-tags', require: 'meta_tags'
gem 'sitemap_generator'
