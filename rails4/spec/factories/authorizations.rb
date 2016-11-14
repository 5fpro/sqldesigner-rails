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

FactoryGirl.define do
  factory :authorization do
    auth { FactoryGirl.create :user }
    provider { :facebook }
    sequence(:uid) { |n| n }
  end

end
