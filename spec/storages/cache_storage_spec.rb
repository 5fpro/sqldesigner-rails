require 'rails_helper'

describe CacheStorage, type: :value do
  let(:key1) { 'a' }
  let(:key2) { 'b' }
  let(:tag1) { 'aa' }
  let(:tag2) { 'bb' }

  it do
    instance = described_class.new(key1, 'x', tags: [tag1])
    expect {
      instance.save
    }.to change { described_class.find_by(tag: tag1).size }.by(1).and \
      change { described_class.exist?(key1) }.to(true)
    expect {
      described_class.find(key1).destroy
    }.to change { described_class.find_by(tag: tag1).size }.by(-1).and \
      change { described_class.exist?(key1) }.to(false)

    described_class.new(key1, 'x', tags: [tag1]).save
    described_class.new(key2, 'x', tags: [tag1, tag2]).save

    expect {
      described_class.clear_by_tags(tag2)
    }.to change { described_class.find_by(tag: tag1).size }.by(-1).and \
      change { described_class.find_by(tag: tag2).size }.by(-1).and \
        change { described_class.exist?(key2) }.to(false).and \
          change { described_class.find(key2) }.to(nil)
    expect(described_class.exist?(key1)).to eq(true)
  end

  describe 'initialize' do
    it 'blank' do
      expect {
        described_class.new(key1, 'x').save
      }.not_to change {
        described_class.find_by(tag: nil).size +
          described_class.find_by(tag: '').size
      }
    end

    it 'string' do
      expect {
        described_class.new(key1, 'x', tags: 'aa').save
      }.to change { described_class.find_by(tag: 'aa').size }.and \
        change { described_class.find_by(tag: :aa).size }
    end

    it 'array' do
      expect {
        described_class.new(key1, 'x', tags: ['aa', :bb]).save
      }.to change { described_class.find_by(tag: 'aa').size }.and \
        change { described_class.find_by(tag: :aa).size }.and \
          change { described_class.find_by(tag: 'bb').size }.and \
            change { described_class.find_by(tag: :bb).size }
    end
  end

  it '.fetch_or_cache' do
    value = described_class.fetch_or_cache(key1, json: true, tags: [:aa]) do
      { a: 1 }
    end
    expect(value[:a]).to eq(1)
    expect(described_class.find_by(tag: :aa).size).to eq(1)
    value = described_class.fetch_or_cache(key1, json: true, tags: [:aa]) do
      { a: 1 }
    end
    expect(value[:a]).to eq(1)
    expect(described_class.find_by(tag: :aa).size).to eq(1)
  end
end
