require 'rails_helper'

describe RetryableConcern, type: :job do
  before { ActiveJob::Base.queue_adapter = :test }

  class TestJobBase < ApplicationJob
    include RetryableConcern

    def perform
      raise 'Error'
    end
  end

  context 'exception class not be included' do
    class ExceptionsJob < TestJobBase
      retryable(exceptions: [NoMethodError])

      def perform(x)
        if x # NoMethodError
          nil.yyy
        else # RuntimeError
          raise 'Test'
        end
      end
    end

    it do
      expect {
        ExceptionsJob.perform_now(true)
      }.to have_enqueued_job(ExceptionsJob)
      expect {
        ExceptionsJob.perform_now(false)
      }.to raise_error(RuntimeError)
    end
  end

  context 'different delays value' do
    class IntegerDelaysJob < TestJobBase
      retryable(delays: 1.minute)
    end

    class ArrayDelaysJob < TestJobBase
      retryable(delays: [1.minute, 1.hour])
      def retry_count
        2
      end
    end

    class ProcDelaysJob < TestJobBase
      retryable(delays: ->(_exception) { retry_count.minutes })
      def retry_count
        3
      end
    end

    class SymbolDelaysJob < TestJobBase
      retryable(delays: :get_delays)

      private

      def get_delays(_exception)
        5.minutes
      end
    end

    it do
      Timecop.freeze(Time.now)
      expect {
        IntegerDelaysJob.perform_now
      }.to have_enqueued_job(IntegerDelaysJob).at(1.minute.from_now)
      expect {
        ArrayDelaysJob.perform_now
      }.to have_enqueued_job(ArrayDelaysJob).at(1.hour.from_now)
      expect {
        ProcDelaysJob.perform_now
      }.to have_enqueued_job(ProcDelaysJob).at(3.minutes.from_now)
      expect {
        SymbolDelaysJob.perform_now
      }.to have_enqueued_job(SymbolDelaysJob).at(5.minutes.from_now)
    end
  end

  context 'over limit' do
    class OverLimitJob < TestJobBase
      retryable(limit: 1)
      def retry_count
        2
      end
    end
    class WithinLimitJob < TestJobBase
      retryable(limit: 10)
      def retry_count
        2
      end
    end
    it do
      expect {
        WithinLimitJob.perform_now
      }.to have_enqueued_job(WithinLimitJob)
      expect {
        OverLimitJob.perform_now
      }.not_to have_enqueued_job(OverLimitJob)
    end
  end

  context 'callbacks' do
    class RetryCallbackJob < TestJobBase
      retryable(limit: 10, onretry: lambda { |exception|
        :halt if exception.is_a?(NoMethodError)
      })
      def perform(x)
        if x # NoMethodError
          nil.yyy
        else # RuntimeError
          raise 'Test'
        end
      end
    end

    class HaltCallbackJob < TestJobBase
      retryable(limit: 10, onhalt: lambda { |exception|
        exception.hash
      })
      def retry_count
        100
      end
    end

    it do
      expect {
        RetryCallbackJob.perform_now(false)
      }.to have_enqueued_job(RetryCallbackJob)
      expect {
        RetryCallbackJob.perform_now(true)
      }.not_to have_enqueued_job(RetryCallbackJob)

      expect_any_instance_of(RuntimeError).to receive(:hash)
      HaltCallbackJob.perform_now
    end
  end
end
