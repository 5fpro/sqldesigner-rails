class BaseForm
  include ObjectErrorsConcern

  # validates_with ExampleValidator

  def save
    raise NotImplementedError
  end

  def valid?
    super
  end
end
