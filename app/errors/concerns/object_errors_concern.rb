module ObjectErrorsConcern
  extend ActiveSupport::Concern

  included do
    extend  ActiveModel::Callbacks
    include ActiveModel::Model
    include ActiveModel::AttributeAssignment
    include ActiveModel::Validations
    include ActiveModel::Validations::Callbacks
  end

  def error_message(attr = nil)
    if attr.present?
      errors.messages[attr.to_sym]&.to_sentence
    else
      errors.full_messages.to_sentence
    end
  end

  def error?(attr = nil, name = nil)
    if attr.present?
      return errors_map.key?(attr) if name.nil?
      collection = attr.to_sym == :any ? errors_map.values.flatten : errors_map[attr]
      (collection || []).map(&:to_sym).include?(name.to_sym)
    else
      !errors.empty?
    end
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
    errors.details.to_a.inject({}) { |h, e| h.merge(e.first => e.last.map(&:values).flatten) }.with_indifferent_access
  end

end
