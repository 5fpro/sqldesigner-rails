class BaseLogger < ApplicationLogger

  LOG_LEVELS = Logger::Severity.constants.map(&:to_s).map(&:downcase)

  class << self
    delegate :log, *LOG_LEVELS, to: :default
  end

  def log(data = {}, merged_data = {})
    data = nomalize_data(data, merged_data)
    log_level = data.delete(:log_level) || ::Lograge.log_level
    formatted_message = log_formatter.call(data)
    public_send(log_level, formatted_message)
    formatted_message
  end

  LOG_LEVELS.each do |log_level|
    class_eval(<<-LOG_LEVEL_METHOD, __FILE__, __LINE__ + 1)
      def #{log_level}(*args)
        if args[0].is_a?(Hash)
          log(args[0].merge(log_level: '#{log_level}'))
        else
          super(*args)
        end
      end
    LOG_LEVEL_METHOD
  end

  private

  def log_formatter
    @log_formatter ||= Lograge::Formatters::KeyValue.new
  end

  def nomalize_data(data, merged_data)
    data = LogData.new(data).to_h unless data.is_a?(Hash)
    data = { logger: self.class.to_s }.merge(data) if self.class != ::BaseLogger
    data.with_indifferent_access.merge(merged_data).inject({}) do |a, e|
      a.merge(e[0] => escape_text(e[1]))
    end
  end

  def escape_text(text)
    text.to_s.force_encoding('UTF-8').gsub("\n", '\n').gsub("\r", '\r')
  end
end
