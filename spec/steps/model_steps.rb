step ':model_finder 的 :attr :have更新' do |instance, attr, have|
  expect {
    instance.reload
  }.public_send have ? :to : :not_to, change { instance.public_send(attr) }
end

step ':model_finder 的 :attr 更新為 \':value\'' do |instance, attr, value|
  expect(instance.public_send(attr).to_s).to eq(value)
end

step ':model_finder 不存在' do |instance|
  expect(instance).to eq(false)
end
