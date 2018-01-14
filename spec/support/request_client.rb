module RequestClient

  def signin(role)
    role_name = role.class.to_s.underscore
    post "/#{role_name.pluralize}/sign_in", params: { role_name => { email: role.email, password: role.password || default_password } }
    instance_variable_set("@current_#{role_name}", role) if response.status == 302
  end

  def current_user
    @current_user
  end

  def current_administrator
    @current_administrator
  end

  def default_password
    '12341234'
  end

  def file_data
    fixture_file_upload('spec/fixtures/5fpro.png', 'image/png')
  end

  def sign_in_admin
    unless current_administrator
      signin(create(:administrator))
    end
  end

  def to_params_list(value)
    return value.hashes if value.respond_to?(:hashes)
    value = parse_body(value) if value.is_a?(String)
    return value.map(:with_indifferent_access) if value.is_a?(Array) && value[0].is_a?(Hash)
    return [value] if value.is_a?(Hash)
    [{}]
  end

  def parse_body(body)
    return {} unless body
    begin
      YAML.load(body)
    rescue
      JSON.parse(body)
    end
  end

  def build_params(model_name, hash, traits: [])
    traits = [traits] if traits && !traits.is_a?(Array)
    params = attributes_for(model_name, *traits, hash.symbolize_keys)
    params.each { |k, v| params[k] = public_send(v) if data_methods.include?(v.to_s.to_sym) }
    params
  end

  def data_methods
    [:file_data]
  end
end
