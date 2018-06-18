# == Schema Information
#
# Table name: categories
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  deleted_at :datetime
#  sort       :integer
#

require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) { create(:category) }

  it 'Factory' do
    expect {
      create(:category)
      create(:category)
    }.to change { Category.count }.by(2)
  end

  it 'acts_as_paranoid' do
    expect(category.restorable?).to eq true
    expect {
      category.destroy
    }.to change { described_class.only_deleted.count }.by(1)
  end

  it 'has_paper_trail' do
    expect {
      category.update_attribute :name, '123123'
    }.to change { category.versions.size }.by(1)
  end

  it 'sortable' do
    category.reload.update_attribute :sort, :up
    category2 = create(:category)
    expect {
      category2.update_attribute :sort, :up
    }.to change { described_class.sorted.try(:first).try(:id) }.to eq category2.id
    expect {
      category.reload.update_attribute :sort, :up
    }.to change { described_class.sorted.try(:first).try(:id) }.to eq category.id
    expect {
      category2.reload.update_attribute :sort, :first
    }.to change { described_class.sorted.try(:first).try(:id) }.to eq category2.id
    expect {
      category2.reload.update_attribute :sort, :remove
    }.to change { described_class.sorted.try(:first).try(:id) }.to eq category.id

  end

  it 'sortable + restorable' do
    category.reload.update_attribute :sort, :up
    expect {
      category.destroy
    }.to change { category.reload.sort }.to(nil)
  end
end
