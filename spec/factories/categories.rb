# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  deleted_at :datetime
#  sort       :integer
#

FactoryBot.define do
  factory :category do
    sequence(:name) { |n| "category #{n}" }

    trait :admin_creation do
      tag_list { ['tag1', 'tag2', 'tag3'] }
    end
  end

end
