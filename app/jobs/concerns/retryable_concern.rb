module RetryableConcern
  extend ActiveSupport::Concern

  module BaseJob
    def deserialize(job_data)
      o = super(job_data)
      o.retry_count = job_data['retry_count'] if o.respond_to?(:retry_count=)
      o
    end
  end

  module ClassMethods
    def retryable(limit: 10, delays: nil, onretry: nil, onhalt: nil, exceptions: nil)
      @retryable_limit = limit.to_i
      delays ||= 10.minutes
      delays = [delays] unless delays.is_a?(Array) || delays.is_a?(Proc) || delays.is_a?(Symbol) || delays.is_a?(String)
      @retryable_delays = delays
      @retryable_onretry = onretry
      @retryable_onhalt = onhalt
      @retryable_exceptions = exceptions || [StandardError]
      @retryable_exceptions = [@retryable_exceptions] unless @retryable_exceptions.is_a?(Array)
      override_base_job!
      retry_by_exceptions!
    end

    private

    def retryable_limit
      @retryable_limit
    end

    def retryable_delays
      @retryable_delays
    end

    def retryable_onretry
      @retryable_onretry
    end

    def retryable_onhalt
      @retryable_onhalt
    end

    def retryable_exceptions
      @retryable_exceptions
    end

    def override_base_job!
      ActiveJob::Base.singleton_class.prepend(::RetryableConcern::BaseJob)
    end

    def retry_by_exceptions!
      instance_eval do
        # Override
        define_method :rescue_with_handler do |exception|
          return super(exception) unless within_retryable_excetions?(exception)
          if reach_retry_limit?
            trigger_on_halt!(exception)
            true
          elsif trigger_on_retry(exception).to_s == 'halt'
            true
          else
            wait = get_wait_time(exception)
            increase_retry_count
            retry_job(wait: wait)
          end
        end
      end
    end
  end

  # Override
  def serialize(*args)
    super(*args).merge('retry_count' => retry_count)
  end

  def retry_count=(v)
    @retry_count = v
  end

  def retry_count
    @retry_count ||= 0
  end

  def reach_retry_limit?
    retry_count > self.class.send(:retryable_limit)
  end

  private

  def increase_retry_count
    @retry_count = retry_count + 1
  end

  def get_wait_time(exception)
    delays = self.class.send(:retryable_delays)
    if delays.is_a?(Proc)
      instance_exec(exception, &delays)
    elsif delays.is_a?(Array)
      delays[retry_count - 1] || delays.first
    else
      execute_method(delays, exception)
    end
  end

  def within_retryable_excetions?(exception)
    self.class.send(:retryable_exceptions).each do |error_klass|
      return true if exception.is_a?(error_klass)
    end
    false
  end

  def trigger_on_halt!(exception)
    onhalt = self.class.send(:retryable_onhalt)
    if onhalt.is_a?(Proc)
      instance_exec(exception, &onhalt)
    else
      execute_method(onhalt, exception)
    end
  end

  def trigger_on_retry(exception)
    onretry = self.class.send(:retryable_onretry)
    if onretry.is_a?(Proc)
      instance_exec(exception, &onretry)
    else
      execute_method(onretry, exception)
    end
  end

  def execute_method(exec, *args)
    send(exec, *args) if exec.is_a?(String) || exec.is_a?(Symbol)
  end
end
