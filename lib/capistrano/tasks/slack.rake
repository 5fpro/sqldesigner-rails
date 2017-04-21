set :slackistrano,   channel: '#notify-deploy',
                     webhook: 'web hook url',
                     klass: Capistrano::DeployMessaging
