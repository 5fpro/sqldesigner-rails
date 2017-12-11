step ':model_finder 已綁定 :auth_provider :count 筆' do |user, auth_provider, count|
  expect(user.authorizations.where(provider: auth_provider).count).to eq(count.to_i)
end

step ':model_finder 的 :auth_provider 資料為:' do |user, auth_provider, table|
  provider_data = table.hashes[0].symbolize_keys
  uid = provider_data.delete(:uid)
  authorization = user.authorizations.where(provider: auth_provider, uid: uid).first
  provider_data.each do |key, value|
    expect(authorization.auth_data.with_indifferent_access[:info][key]).to eq(value)
  end
end

step ':model_finder 綁定 :auth_provider' do |user, auth_provider, table|
  create(:authorization, auth: user, provider: auth_provider, uid: table.hashes[0].symbolize_keys[:uid])
end

step ':auth_provider 登入' do |auth_provider, table|
  get "/authorizations/#{auth_provider}/callback", env: auth_mock(auth_provider, table)
end

def auth_mock(auth_provider, table)
  provider_data = table.hashes[0].symbolize_keys
  email = provider_data[:email]
  uid = provider_data[:uid]
  name = provider_data[:name]
  mock_data = omniauth_mock(auth_provider.to_sym)
  mock_data[:info][:email] = email.delete(' ') if email.is_a?(String)
  mock_data[:uid] = uid.delete(' ') if uid.is_a?(String)
  mock_data[:info][:name] = name if name.present?
  { 'omniauth.auth' => mock_data }
end
