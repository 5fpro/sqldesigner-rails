module Errors::HandlerConcern
  extend ActiveSupport::Concern

  def errors
    @errors || {}
  end

  def error_messages
    @errors.values.inject([]) { |acc, elem| acc + elem }
  end

  def has_error?
    return false unless @errors
    !@errors.empty?
  end

  protected

  def add_error(key, custom_message = nil)
    ::Error.raise!(:error_code_not_defined, custom_message: custom_message) unless Errors::Code.exists?(key)
    @errors ||= {}
    @errors[key.to_sym] ||= []
    @errors[key.to_sym] << (custom_message || Errors::Code.desc(key))
    throw(:abort)
  end

end
