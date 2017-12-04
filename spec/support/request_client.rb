module RequestClient
  def signout_user
    delete '/users/sign_out'
    @current_user = nil
  end

  def signin_user(user = nil)
    user ||= create(:user, :admin)
    post '/users/sign_in', params: { user: { email: user.email, password: user.password || default_password } }
    @current_user = user if response.status == 302
  end

  def current_user
    @current_user
  end

  def default_password
    '12341234'
  end

  def file_data
    fixture_file_upload('spec/fixtures/5fpro.png', 'image/png')
  end

  def sign_in_admin
    unless current_user&.admin?
      signin_user(create(:user, :admin))
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
    params = { model_name.to_sym => params }
  end

  def data_methods
    [:file_data]
  end
end
