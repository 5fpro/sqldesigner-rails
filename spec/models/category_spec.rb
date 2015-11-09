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
    }.to change{ described_class.only_deleted.count }.by(1)
  end

  it "has_paper_trail" do
    expect{
      category.update_attribute :name, "123123"
    }.to change{ category.versions.size }.by(1)
  end

  it "ranked-model" do
    category
    category2 = FactoryGirl.create :category
    expect{
      category2.insert_at(1)
    }.to change{ described_class.where.not(sort: nil).order("sort ASC").try(:first).try(:id) }.to eq category2.id
    expect{
      category.reload.insert_at(1)
    }.to change{ described_class.where.not(sort: nil).order("sort ASC").try(:first).try(:id) }.to eq category.id
    expect{
      category2.reload.move_to_top
    }.to change{ described_class.where.not(sort: nil).order("sort ASC").try(:first).try(:id) }.to eq category2.id
    expect{
      category2.reload.remove_from_list
    }.to change{ described_class.where.not(sort: nil).order("sort ASC").try(:first).try(:id) }.to eq category.id
  end
end
