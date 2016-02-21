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

FactoryGirl.define do
  factory :category do
    sequence(:name) { |n| "category #{n}" }
  end

end
