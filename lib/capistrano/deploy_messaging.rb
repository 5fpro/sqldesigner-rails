class Capistrano::DeployMessaging < Slackistrano::Messaging::Base
  def channels_for(action)
    super
  end

  def payload_for_updating
    create_payload(
      'deploying',
      "#{deployer} has started deploying #{application}. :face_with_rolling_eyes:",
      '#AAAAAA'
    )
  end

  def payload_for_reverting
    nil
  end

  def payload_for_updated
    create_payload(
      'deployed',
      "#{deployer} has deployed #{application}. :smirk:",
      '#36a64f'
    )
  end

  def payload_for_reverted
    nil
  end

  def payload_for_failed
    create_payload(
      'fail',
      "#{deployer} has fail to deploy #{application}. :rage:",
      '#DC322F'
    )
  end

  def icon_url
    # 'https://raw.githubusercontent.com/phallstrom/slackistrano/master/images/slackistrano.png',
    nil
  end

  def icon_emoji
    ':rocket:'
  end

  def username
    'Capistrano'
  end

  private

  def create_payload(action, message, color)
    {
      attachments: [{
        title: message,
        color: color,
        fields: [
          {
            title: 'Deployer',
            value: deployer,
            short: true
          },
          {
            title: 'Action',
            value: action,
            short: true
          },
          {
            title: 'App',
            value: application,
            short: false
          },
          {
            title: 'Branch',
            value: branch,
            short: true
          },
          {
            title: 'Stage',
            value: stage,
            short: true
          }
        ],
        footer: '5FPRO',
        footer_icon: 'https://5fpro.com/images/icon.png',
        ts: Time.now.to_i
      }]
    }
  end
end
