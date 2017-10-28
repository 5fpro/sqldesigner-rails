step ':model_finder 設為未驗證' do |user|
  user.update(confirmed_at: nil)
end

step ':model_finder 狀態為已驗證' do |user|
  expect(user.confirmed?).to eq(true)
end

step ':model_finder 已綁定 :auth_provider :count 筆' do |user, auth_provider, count|
  expect(user.authorizations.where(provider: auth_provider).count).to eq(count.to_i)
end

step '使用者登出' do
  delete '/users/sign_out'
end

step '使用者已登入' do
  get '/users/sign_in'
  expect(response).to be_redirect
end

step '使用者未登入' do
  get '/users/sign_in'
  expect(response).to be_success
end

step ':model_finder 的 :auth_provider 資料為:' do |user, auth_provider, table|
  provider_data = table.rows_hash.symbolize_keys
  uid = provider_data.delete(:uid)
  authorization = user.authorizations.where(provider: auth_provider, uid: uid).first
  provider_data.each do |key, value|
    expect(authorization.auth_data.with_indifferent_access[:info][key]).to eq(value)
  end
end

step '使用者登入' do
  @current_user = @user || @users.try(:first) || @current_user || create(:user)
  post '/users/sign_in', params: { user: { email: @current_user.email, password: @current_user.password } }
  expect(response).to redirect_to('/')
end

step '使用者登入:' do |table|
  @current_user = create(:user, table.rows_hash.symbolize_keys)
  post '/users/sign_in', params: { user: { email: @current_user.email, password: @current_user.password } }
  expect(response).to redirect_to('/')
end

step ':model_finder 綁定 :auth_provider' do |user, auth_provider, table|
  delete '/users/sign_out'
  post '/users/sign_in', params: { user: { email: user.email, password: user.password || '12341234' } }
  get "/authorizations/#{auth_provider}/callback", env: auth_mock(auth_provider, table)
  delete '/users/sign_out'
end

step ':auth_provider 登入' do |auth_provider, table|
  get "/authorizations/#{auth_provider}/callback", env: auth_mock(auth_provider, table)
end

def auth_mock(auth_provider, table)
  provider_data = table.rows_hash.symbolize_keys
  email = provider_data[:email]
  uid = provider_data[:uid]
  name = provider_data[:name]
  mock_data = omniauth_mock(auth_provider.to_sym)
  mock_data[:info][:email] = email.delete(' ') if email.is_a?(String)
  mock_data[:uid] = uid.delete(' ') if uid.is_a?(String)
  mock_data[:info][:name] = name if name.present?
  { 'omniauth.auth' => mock_data }
end
