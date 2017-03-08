# aws ses: https://github.com/aws/aws-sdk-ruby/
AWS.config(Setting.aws)
ActionMailer::Base.default_url_options = { host: Setting.host, protocol: Setting.default_protocol }
ActionMailer::Base.asset_host = "#{Setting.default_protocol}://#{Setting.carrierwave.host}"
