step ':model_finder 狀態為已驗證' do |instance|
  expect(instance.confirmed?).to eq(true)
end

step ':model_finder 有頭像' do |instance|
  expect(instance.avatar.url).to be_present
end

step ':model_finder 密碼為 :password' do |instance, password|
  expect(instance.valid_password?(password)).to eq(true)
end

step ':model_finder 密碼不為 :password' do |instance, password|
  expect(instance.valid_password?(password)).to eq(false)
end
