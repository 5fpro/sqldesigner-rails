Rails.application.config.middleware.use OmniAuth::Builder do
  # perms = 'email,offline_access,user_checkins,friends_checkins,user_location'
  fb_app_id = Setting.facebook_app_id rescue ENV["facebook_app_id"]
  fb_secret = Setting.facebook_secret rescue ENV["facebook_secret"]
  fb_perms = Setting.facebook_perms rescue ENV["facebook_perms"]
  provider :facebook, fb_app_id, fb_secret, :scope => fb_perms
end