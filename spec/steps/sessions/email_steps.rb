step ':user_role 登入' do |user|
  @current_user ||= user
  signin_user(@current_user)
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

