# == Schema Information
#
# Table name: page_blocks
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  body       :text
#  enabled    :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :page_block do
    name { :test }
    body { '<p>OK</p>' }
    enabled { true }

    trait :admin_creation do
      enabled { '1' }
    end
  end
end
