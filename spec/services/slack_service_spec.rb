require 'rails_helper'

RSpec.describe SlackService, type: :service do
  it '.notify' do
    described_class.notify('haha')
  end

  it '.notify_async' do
    described_class.notify_async('haha')
    expect(SlackNotifyJob).to have_been_enqueued
  end
end
