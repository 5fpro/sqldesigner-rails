# https://github.com/phallstrom/slackistrano/blob/master/lib/slackistrano/tasks/slack.rake
namespace :load do
  task :defaults do
    set :slack_team,         -> { 'your_team_name' }
    set :slack_webhook,      -> { '12341234' }
    set :slack_icon_url,     -> { 'https://slack-assets2.s3-us-west-2.amazonaws.com/5504/img/emoji/1f680.png' }
    set :slack_channel,      -> { '#general' }
    set :slack_username,     -> { 'myapp' }
    set :slack_msg_updating, -> { "#{fetch :slack_deploy_user} has started deploying branch #{fetch :branch} of #{fetch :application} to #{fetch :stage, 'an unknown stage'}" }
    set :slack_msg_reverting, -> { "#{fetch :slack_deploy_user} has started rolling back branch #{fetch :branch} of #{fetch :application} to #{fetch :stage, 'an unknown stage'}" }
    set :slack_msg_updated,  -> { "#{fetch :slack_deploy_user} has finished deploying branch #{fetch :branch} of #{fetch :application} to #{fetch :stage, 'an unknown stage'}" }
    set :slack_msg_reverted, -> { "#{fetch :slack_deploy_user} has finished rolling back branch of #{fetch :application} to #{fetch :stage, 'an unknown stage'}" }
    set :slack_msg_failed,   -> { "#{fetch :slack_deploy_user} has failed to #{fetch(:slack_deploy_or_rollback) || 'deploy'} branch #{fetch :branch} of #{fetch :application} to #{fetch :stage, 'an unknown stage'}" }
    # set :slack_via_slackbot, ->{ false }
    # set :slack_token,        ->{ '' }
  end
end
