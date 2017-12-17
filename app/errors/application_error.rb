class ApplicationError < RuntimeError
  class << self
    private

    def logger(logger_class)
      @logger = logger_class.default
    end

    def get_logger
      @logger ||= BaseLogger.default
    end
  end

  attr_accessor :original, :context

  def initialize(message: nil, context: nil, original: nil, **args)
    @message = message
    @context = context || {}
    @original = original
    super(message)
    custom_initialize(**args)
  end

  def message
    @message ||= I18n.t("errors.#{i18n_path}.message", default: nil)
  end

  def original_message
    @original&.message || message
  end

  def original_backtrace
    @original&.backtrace || backtrace
  end

  def notify
    Rollbar.error(original || self, to_h)
  end

  def mail_deliver
    ErrorMailer.notify(self).deliver_now
  end

  def log(data = {})
    self.class.send(:get_logger).log(to_h.merge(data).merge(type: 'Error'))
  end

  def to_h
    {
      class_name: self.class.to_s,
      message: message,
      backtrace: backtrace,
      context: safe_to_h(@context),
      logger: {
        class_name: logger.class.to_s,
        file_path: logger.file_path.to_s
      },
      original: original_to_h
    }.deep_merge(safe_to_h(custom_to_h)).with_indifferent_access
  end

  def to_json
    to_h.to_json
  end

  private

  # you can overwrite this
  def custom_to_h
    {}
  end

  # you can overwrite this
  def custom_initialize(*args); end

  def safe_to_h(h)
    JSON.parse(h.to_json).with_indifferent_access
  end

  def i18n_path
    # Abc::DefError -> abc.def
    self.class.to_s.underscore.split('/').join('.').gsub('_error', '')
  end

  def logger
    @logger ||= self.class.send(:get_logger)
  end

  def original_to_h
    return nil unless @original
    if @original.is_a?(ApplicationError)
      @original.to_h
    else
      {
        class_name: @original.class.to_s,
        message: @original.message,
        backtrace: @original.backtrace
      }
    end
  end
end
