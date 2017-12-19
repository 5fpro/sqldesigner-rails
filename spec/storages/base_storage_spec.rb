require 'rails_helper'

describe BaseStorage, type: :storage do
  class ExampleStorage < BaseStorage
    default_expires 20.seconds
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

    expect(instance.ttl).to be > 0

    expect {
      instance.destroy
    }.to change { klass.all.count }.to(0)

    base = BaseStorage.new
    base.save
    expect(base.ttl).to eq(-1)
  end

  describe 'Callbacks' do
    class CallbackStorage < ExampleStorage
      attr_accessor :name, :hi, :hello, :yo, :aloha

      before_save :call_hi
      after_save :call_hello
      before_destroy :call_yo
      after_destroy :call_aloha

      private

      def call_hi
        @hi = 1
      end

      def call_hello
        @hello = 2
      end

      def call_yo
        throw :abort
      end

      def call_aloha
        @aloha = 3
      end
    end

    let(:klass) { CallbackStorage }

    it do
      instance = klass.new(name: 'abc')
      @id = instance.save
      expect(@id).to be_present
      expect(instance.hi).to eq(1)
      expect(instance.hello).to eq(2)
      found_instance = klass.find(@id)
      expect(found_instance.hi).to eq(1)
      expect(found_instance.hello).to eq(nil)
      expect(instance.destroy).to eq(false)
      expect(instance.aloha).to eq(nil)
      expect(klass.exists?(@id)).to eq(true)
    end
  end
end
