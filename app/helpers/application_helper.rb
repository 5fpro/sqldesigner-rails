module ApplicationHelper
  def fb_app_id
    Setting.facebook_app_id rescue ENV["facebook_app_id"]
  end

  def app_name
    Setting.app_name rescue ENV["app_name"]
  end

  def google_analytics_key
    Setting.google_analytics_key rescue ENV["google_analytics_key"]
  end

  def domain
    Setting.domain rescue ENV["domain"]
  end
end
