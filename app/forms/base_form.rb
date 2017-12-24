class BaseForm
  extend ActiveModel::Callbacks
  include ObjectErrorsConcern

  define_model_callbacks :save

  # validates_with ExampleValidator

  def initialize(params = {})
    assign_attributes(params)
    valid?
  end

  def save
    raise NotImplementedError
  end

  def attributes
    as_json.with_indifferent_access
  end
end
