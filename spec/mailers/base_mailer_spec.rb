require 'rails_helper'

RSpec.describe BaseMailer, type: :mailer do
  it '#notify' do
    mail = described_class.notify.deliver_now
    expect(mail.body).to match('Hello')
  end
end
