class Setting < Settingslogic
  source Rails.root.join('config', 'application.yml')
  namespace Rails.env

  # SUPPORT: SSL
  def default_protocol
    'https'
  end
end
