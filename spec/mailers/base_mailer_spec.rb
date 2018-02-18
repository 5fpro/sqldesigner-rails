require 'rails_helper'

RSpec.describe BaseMailer, type: :mailer do
  it '#notify' do
    mail = described_class.notify.deliver_now
    expect(mail.body).to include(I18n.t('base_mailer.notify.hello'))
    expect(mail.subject).to include(I18n.t('base_mailer.notify.subject'))
  end
end
