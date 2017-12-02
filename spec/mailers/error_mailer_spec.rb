require 'rails_helper'

RSpec.describe ErrorMailer, type: :mailer do
  it '#notify' do
    error = ApplicationError.new(message: 'ha')
    mail = described_class.notify(error).deliver_now
    expect(mail.body).to match(error.message)
  end
end
