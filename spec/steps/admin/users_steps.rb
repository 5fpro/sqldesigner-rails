step '後台建立使用者:' do |table|
  @users_count = User.count
  params = { user: attributes_for(:user, :admin_creation, table.rows_hash.symbolize_keys) }
  params[:user][:avatar] = file_data if params[:user][:avatar].present?
  post '/admin/users', params: params
end

step '後台更新使用者 :model_finder:' do |instance, table|
  @user = instance
  params = {
    user: table.rows_hash.symbolize_keys
  }
  put "/admin/users/#{instance.id}", params: params
end

step '後台刪除使用者 :model_finder' do |instance|
  @user = instance
  delete "/admin/users/#{instance.id}"
end

step '使用者數 :count_changed' do |changed|
  expect(@users_count + changed).to eq(User.count)
end

step '使用者(:name)有頭像' do |name|
  @user ||= User.last
  expect(@user.name).to eq(name)
  expect(@user.avatar.url).to be_present
end
