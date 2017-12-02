module Util
  def omniauth_mock(provider)
    OmniAuth.config.mock_auth[provider]
  end

  def read_fixtures(filename)
    IO.read(Rails.root.join('spec').join('fixtures').join(filename))
  end

  def set_previous_count(model_name)
    klass = to_klass(model_name)
    @previous_count ||= {}
    @previous_count[klass.to_s] = klass.count
  end

  def get_previous_count(model_name)
    (@previous_count || {})[to_klass(model_name).to_s]
  end

  def to_klass(model_name)
    model_name.to_s.camelize.constantize
  end

  def to_model_name(klass)
    klass.to_s.underscore.split('/').last
  end
end
