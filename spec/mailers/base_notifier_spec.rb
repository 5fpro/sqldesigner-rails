require 'rails_helper'

RSpec.describe BaseNotifier, type: :mailer do
  it '#notify' do
    mail = BaseNotifier.notify.deliver_now
    expect(mail.body).to match('Hello')
  end
end
