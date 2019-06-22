# frozen_string_literal: true

# == Schema Information
#
# Table name: administrators
#
#  id                     :bigint(8)        not null, primary key
#  name                   :string
#  root                   :boolean          default(FALSE)
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
#
FactoryBot.define do
  factory :administrator do
    name { '5Fpro' }
    sequence(:email) { |n| "admin#{n}@5fpro.com" }
    password { '12341234' }
    root { false }

    trait :admin_creation do
      root { '0' }
    end

    trait :root do
      root { true }
    end
  end
end
