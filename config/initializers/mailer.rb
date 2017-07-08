creds = Aws::Credentials.new(Setting.aws.access_key_id, Setting.aws.secret_access_key)
Aws::Rails.add_action_mailer_delivery_method(:aws_sdk, credentials: creds, region: 'us-east-1')

ActionMailer::Base.default_url_options = { host: Setting.host, protocol: Setting.default_protocol }
ActionMailer::Base.asset_host = "#{Setting.default_protocol}://#{Setting.carrierwave.host}"
