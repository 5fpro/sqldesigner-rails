require 'rails_helper'

describe BaseStorage, type: :storage do
  class ExampleStorage < BaseStorage
    default_expires 10.seconds
    attr_accessor :name
  end

  let(:klass) { ExampleStorage }

  it do
    expect {
      @id = klass.new(name: 'abc').save
    }.to change { klass.all.count }.by(1)
    expect(described_class.all.count).to eq(0)
    instance = klass.find(@id)
    expect(instance).to be_present
    expect {
      instance.update(name: 'QQ')
    }.to change { klass.find(@id).name }.to('QQ')
    expect {
      instance.destroy
    }.to change { klass.all.count }.to(0)
  end
end
