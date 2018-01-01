class BaseValidator < ActiveModel::Validator
  def validate(_instance)
    raise NotImplementedError
  end
end
