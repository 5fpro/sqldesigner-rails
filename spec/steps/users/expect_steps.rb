step ':model_finder 狀態為已驗證' do |user|
  expect(user.confirmed?).to eq(true)
end

step ':model_finder 有頭像' do |instance|
  @user = instance
  expect(@user.avatar.url).to be_present
end
