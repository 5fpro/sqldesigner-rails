# == Schema Information
#
# Table name: event_logs
#
#  id          :bigint(8)        not null, primary key
#  event_type  :string
#  description :string
#  identity    :string
#  created_on  :date
#  data        :json
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryBot.define do
  factory :event_log do
    event_type { :test }
    sequence(:identity) { |n| "123-#{n}" }
  end
end
