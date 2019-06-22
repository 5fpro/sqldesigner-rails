namespace :load do
  task :defaults do
    set :rollbar_role, -> { :db }
    set :sidekiq_role, -> { :worker }
    set :asset_sync_enable, -> { true }
    set :asset_sync_roles,  -> { :worker }
  end
end

set :slackistrano, channel: '#rails-template-notify',
                   webhook: ENV['DEPLOY_SLACK_WEBHOOK'],
                   klass: Capistrano::DeployMessaging
