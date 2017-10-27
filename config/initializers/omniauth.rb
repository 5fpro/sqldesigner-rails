Rails.application.config.middleware.use OmniAuth::Builder do
  Setting.omniauth.providers.each do |provider, data|
    data = data.deep_symbolize_keys
    provider provider, data[:token], data[:secret], data[:options] || {}
  end
end

OmniAuth.config.path_prefix = "/authorizations"
