# == Schema Information
#
# Table name: authorizations
#
#  id         :integer          not null, primary key
#  provider   :integer
#  uid        :string
#  auth_type  :string
#  auth_id    :integer
#  auth_data  :text
#  data       :hstore
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :authorization, class: 'Tyr::Authorization' do
    auth { create :user }
    provider { :facebook }
    sequence(:uid) { |n| n }
  end

end
