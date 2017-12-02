step ':model_finder 狀態為已驗證' do |instance|
  expect(instance.confirmed?).to eq(true)
end

step ':model_finder 有頭像' do |instance|
  expect(instance.avatar.url).to be_present
end
