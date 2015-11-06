# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Category, type: :model do
  it "FactoryGirl" do
    expect{
      FactoryGirl.create :category
      FactoryGirl.create :category
    }.to change{ Category.count }.by(2)
  end
end
