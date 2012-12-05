Rails.application.config.middleware.use OmniAuth::Builder do
  $Omniauth_Config = ActiveSupport::HashWithIndifferentAccess.new(YAML.load(File.open("#{Rails.root}/config/omniauth.yml"))[Rails.env])
  # perms = 'email,offline_access,user_checkins,friends_checkins,user_location'
  provider :facebook, $Omniauth_Config[:facebook][:app_id], $Omniauth_Config[:facebook][:api_secret], :scope => $Omniauth_Config[:facebook][:perms]
end