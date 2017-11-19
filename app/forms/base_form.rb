class BaseForm
  include ActiveModel::Model

  # validates_with ExampleValidator

  def save
    fail NotImplementedError
  end

  def valid?
    super
  end
end
