# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  admin                  :boolean          default(FALSE)
#  avatar                 :string
#

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  it 'Factory' do
    expect(user).not_to be_new_record
    expect(create(:user, :with_avatar).avatar.url).to be_present
  end

  it 'devise async' do
    expect {
      create :user, :unconfirmed
    }.to enqueue_job(ActionMailer::DeliveryJob)
    expect {
      user
    }.not_to have_enqueued_job(ActionMailer::DeliveryJob)
  end
end
