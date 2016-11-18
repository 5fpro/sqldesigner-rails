# aws ses: https://github.com/aws/aws-sdk-ruby/
AWS.config(Setting.aws)
# SUPPORT: SSL
# ActionMailer::Base.default_url_options = { host: Setting.host, protocol: "https" }
ActionMailer::Base.default_url_options = { host: Setting.host }
ActionMailer::Base.asset_host = "http://#{Setting.carrierwave.host}" # S3 not support SSL
