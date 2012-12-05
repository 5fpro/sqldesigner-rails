Rails.application.config.middleware.use OmniAuth::Builder do
  # perms = 'email,offline_access,user_checkins,friends_checkins,user_location'
  provider :facebook, Setting.facebook_app_id, Setting.facebook_secret, :scope => Setting.facebook_perms
end