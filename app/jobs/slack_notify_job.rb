class SlackNotifyJob < ApplicationJob
  def perform(message, options)
    SlackService.notify(message, options)
  end
end
