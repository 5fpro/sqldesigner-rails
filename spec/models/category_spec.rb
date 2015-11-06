# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  deleted_at :datetime
#

require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category){ FactoryGirl.create :category }

  it "FactoryGirl" do
    expect{
      FactoryGirl.create :category
      FactoryGirl.create :category
    }.to change{ Category.count }.by(2)
  end

  it "acts_as_paranoid" do
    category
    expect{
      category.destroy
    }.to change{ Category.only_deleted.count }.by(1)
  end

  it "has_paper_trail" do
    expect{
      category.update_attribute :name, "123123"
    }.to change{ category.versions.size }.by(1)
  end
end
