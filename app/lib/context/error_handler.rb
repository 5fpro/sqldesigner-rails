module Context::ErrorHandler
  extend ActiveSupport::Concern

  def errors
    @errors || {}
  end

  def error_messages
    @errors.values.inject([]){ |s, messages| s + messages }
  end

  def has_error?
    return false unless @errors
    @errors.size > 0
  end

  protected

  def add_error(key, custom_message = nil)
    @errors ||= {}
    @errors[key.to_sym] ||= []
    @errors[key.to_sym] << custom_message || I18n.t("errors.#{key}.message", default: key.to_s)
    false
  end
end
