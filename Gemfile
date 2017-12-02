source 'https://rubygems.org'

gem 'rails', '~> 5.1'

gem 'dotenv-rails', require: 'dotenv/rails-now'

# DB
gem 'activerecord-postgis-adapter'
gem 'pg'
gem 'redis'
gem 'redis-objects', require: 'redis/objects'

# stores
gem 'connection_pool'
gem 'dalli'

# ENV
gem 'settingslogic'

# view rendering
gem 'jbuilder', '~> 2.0'
gem 'nested_form'
gem 'simple_form'
gem 'slim'

# assets
gem 'asset_sync'
gem 'coffee-rails', '~> 4.2'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'

# JS plugin
gem 'jquery-rails'
gem 'turbolinks', '~> 5'

# background jobs
gem 'sidekiq'
gem 'sidekiq-limit_fetch'
gem 'sidekiq-scheduler'
gem 'sinatra', '~> 2.0'

# file upload
gem 'carrierwave'
gem 'carrierwave_backgrounder', git: 'git@github.com:lardawge/carrierwave_backgrounder.git'
gem 'fog-aws'
gem 'mini_magick'

# soft delete
gem 'paranoia'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
group :staging, :production do
  # gem 'newrelic_rpm'
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
  gem 'http_logger'
  gem 'rubocop'
  gem 'web-console', '~> 3.0'
  gem 'xray-rails'

  gem 'spring'
  gem 'spring-commands-rspec'

  gem 'rails_real_favicon'
end

group :development, :test do
  gem 'byebug'
  gem 'factory_bot_rails'
  gem 'listen'
  gem 'rspec'
  gem 'rspec-rails'
  # gem 'rename'
end

group :test do
  gem 'database_cleaner'
  gem 'timecop'
  gem 'turnip'
  gem 'webmock'
end

group :doc do
  gem 'sdoc', '~> 0.4.0'
end

gem 'kaminari'
gem 'lograge', require: true
gem 'rollbar'

# devise
gem 'devise'
gem 'devise-async'

# aws
gem 'aws-sdk-rails'

# unicorn
gem 'unicorn'

# versioning
gem 'paper_trail'

gem 'acts-as-taggable-on'
gem 'ransack'
gem 'slack-notifier'

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

# SEO
gem 'breadcrumbs_on_rails'
gem 'meta-tags', require: 'meta_tags'
gem 'sitemap_generator'

# middleware
gem 'rack-cors', require: 'rack/cors'

gem 'redactor2_rails'
