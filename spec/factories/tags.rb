# == Schema Information
#
# Table name: tags
#
#  id             :bigint(8)        not null, primary key
#  name           :string
#  taggings_count :integer          default(0)
#

FactoryBot.define do
  factory :tag do

  end

end
