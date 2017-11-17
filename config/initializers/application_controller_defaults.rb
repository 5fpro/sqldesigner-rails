# Be sure to restart your server when you modify this file.

ActiveSupport::Reloader.to_prepare do
  ApplicationController.renderer.defaults.merge!(
    http_host: Setting.host,
    https: Setting.default_protocol.to_s.downcase == 'https'
  )

  ApplicationController.default_url_options.merge!(
    protocol: Setting.default_protocol,
    host: Setting.host
  )

  Rails.application.routes.default_url_options.merge!(
    protocol: Setting.default_protocol,
    host: Setting.host
  )
end

