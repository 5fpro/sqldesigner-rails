# Be sure to restart your server when you modify this file.

# Config@initial
Rails.application.config.session_store :cookie_store, key: "_#{ENV['APP_NAME']}_session"
