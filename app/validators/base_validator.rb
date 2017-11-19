class BaseValidator < ActiveModel::Validator

  def validate(instance)
    fail NotImplementedError
  end
end
