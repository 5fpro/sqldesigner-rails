require 'rails_helper'

describe ApplicationError, type: :error do
  let(:exception) { described_class.new(message: message, context: context, original: original) }
  let(:message) { 'test message' }
  let(:context) { { haha: Time.now } }
  let(:original) { StandardError.new }

  it '#log, #message, #mail_deliver' do
    expect(exception.log).to be_present
    expect(exception.message).to include(message)
    expect(exception.to_json).to include(message)
    expect(exception.mail_deliver).to be_present
  end

  context 'default message' do
    let(:message) { nil }
    it { expect(exception.message).to be_present }
  end

  context 'Override Class' do
    class ExampleLogger < BaseLogger
    end

    class ExampleError < ApplicationError
      logger ExampleLogger

      private

      def status
        404
      end

      def custom_to_h
        {
          status: status,
          now: Time.now,
          a: @a,
          b: @b
        }
      end

      def custom_initialize(a:, b:)
        @a = a
        @b = b
      end
    end

    let(:exception) { ExampleError.new(context: context, message: 'hoho', a: 1, b: 2) }
    it do
      expect(exception.message).to be_present
      expect(exception.to_h[:status]).to eq(404)
      expect(exception.to_h[:a]).to be_present
      expect(exception.to_h[:b]).to be_present
      expect(exception.log).to be_present
    end

    it 'ArgumentError' do
      expect {
        ExampleError.new(context: context, message: 'hoho', a: 1)
      }.to raise_error(ArgumentError)
    end
  end
end
