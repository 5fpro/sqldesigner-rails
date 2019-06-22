# == Schema Information
#
# Table name: article_categories
#
#  id             :bigint(8)        not null, primary key
#  layout         :string
#  name           :string
#  enabled        :boolean          default(TRUE)
#  sort           :integer
#  parent_id      :integer
#  deep           :integer          default(0)
#  articles_count :integer          default(0)
#  deleted_at     :datetime
#  data           :jsonb
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

FactoryBot.define do
  factory :article_category do
    layout { 'default' }
    sequence(:name) { |n| "category-#{n}" }
    enabled { true }
  end
end
