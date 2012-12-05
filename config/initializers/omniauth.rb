Rails.application.config.middleware.use OmniAuth::Builder do
  $Omniauth_Config = ActiveSupport::HashWithIndifferentAccess.new(YAML.load(File.open("#{Rails.root}/config/omniauth.yml"))[Rails.env])
  # perms = 'email,offline_access,user_checkins,friends_checkins,user_location'
  provider :facebook, Setting.facebook_app_id, Setting.facebook_secret, :scope => Setting.facebook_perms
end