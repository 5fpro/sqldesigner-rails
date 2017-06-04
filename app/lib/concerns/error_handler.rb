module ErrorHandler
  extend ActiveSupport::Concern

  included do
    include ActiveModel::Model
  end

  def error_messages
    errors.full_messages
  end

  def error?
    !errors.empty?
  end

  def has_error?(name, attr: :any)
    collection = attr.to_sym == :any ? errors_map.values.flatten : errors_map[attr.to_sym]
    collection.map(&:to_sym).include?(name.to_sym)
  end

  def errors=(errors)
    @errors = errors
  end

  private

  # to:
  #   {
  #     base: [:not_found, :taken],
  #     email: [:not_found]
  #   }
  #
  def errors_map
    errors.details.to_a.inject({}) { |h, e| h.merge(e.first => e.last.map(&:values).flatten) }.symbolize_keys
  end
end
