class BaseForm
  extend  ActiveModel::Callbacks
  include ActiveModel::Validations
  include ActiveModel::Validations::Callbacks

  include AttributesConcern
  include ObjectErrorsConcern

  define_model_callbacks :save

  # validates_with ExampleValidator

  def initialize(params = {})
    unless params.is_a?(Hash) || params.is_a?(ActionController::Parameters)
      @_object = params
      params = params.to_h.with_indifferent_access.select { |k, _v| self.class.attributes.include?(k.to_sym) }
    end
    assign_attributes(params)
    valid?
  end

  def save
    raise NotImplementedError
  end

  # override
  def new_record?
    return false if @_object.try(:id)&.blank? == false || @_object.try(:new_record?) == false
    true
  end

  def persisted?
    !new_record?
  end
end
