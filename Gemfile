source 'https://rubygems.org'
gem 'rails', '4.2.6'

# DB
gem 'pg'
gem 'activerecord-postgis-adapter'
gem 'redis'
gem 'redis-objects', require: "redis/objects"

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
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'therubyracer', platforms: :ruby
gem 'asset_sync'

# JS plugin
gem 'jquery-rails'
gem 'select2-rails', '~> 3'
gem 'turbolinks'

# background jobs
gem 'sidekiq'
gem 'sinatra', '>= 1.3.0', require: nil
gem 'sidekiq-limit_fetch'
gem 'sidetiq'
gem 'whenever'

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
  gem 'capistrano-rvm'
  gem 'capistrano-sidekiq'
  # unicorn
  gem 'capistrano3-unicorn'
  # slack
  gem 'slackistrano', require: false

  gem 'guard-annotate'
  gem 'annotate'
  gem 'awesome_print'
  gem 'xray-rails'
  gem 'pry'
  gem 'pry-rails'
  gem 'pry-remote'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'guard'
  gem 'http_logger'
  gem 'spring'
  gem 'venus', git: "git@github.com:marsz/venus.git", branch: 'v1.0'
  gem 'web-console', '~> 2.0'
  gem 'rubocop'
end

group :development, :test do
  gem 'rspec'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'byebug'
end

group :test do
  gem 'webmock'
  gem 'test_after_commit'
  gem 'timecop'
  gem 'fuubar'
end

group :doc do
  gem 'sdoc', '~> 0.4.0'
end

gem 'rollbar'
gem 'kaminari'

# devise
gem 'devise'
gem 'devise-async'

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
gem 'omniauth-oauth2', '~> 1.3.1' # for fix google oauth2

# front-end
gem 'jquery-ui-rails'
gem 'bootstrap-sass', '~> 2.3'

# SEO
gem 'crummy'
gem 'meta-tags', require: 'meta_tags'
gem 'sitemap_generator'
