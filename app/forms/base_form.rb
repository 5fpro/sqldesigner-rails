class BaseForm
  include ActiveModel::Model

  def save
    fail NotImplementedError
  end
end
