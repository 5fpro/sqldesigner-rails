set :slackistrano,   channel: '#notify-deploy',
                     webhook: ENV['DEPLOY_SLACK_WEBHOOK'],
                     klass: Capistrano::DeployMessaging
