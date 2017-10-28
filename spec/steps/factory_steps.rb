step '已註冊 users:' do |table|
  @users = table.hashes.map { |h| create(:user, h) }
end
