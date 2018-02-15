step ':model_finder 的 :attr 為 :value' do |instance, attr, value|
  expect(instance.public_send(attr).to_s).to eq(value)
end

step ':model_finder 的 :attr :string_matcher( )' do |instance, attr, matcher_bind_str|
  str = instance.public_send(attr).to_s
  eval(matcher_bind_str)
end

step ':model_finder 的 :attr :string_matcher :value' do |instance, attr, matcher_bind_str, value|
  str = instance.public_send(attr).to_s
  eval(matcher_bind_str)
end

step ':model_finder :have存在' do |instance, have|
  expect(instance.present?).to eq(have)
end

step ':model_name 數 :count_changed' do |model_name, changed|
  expect(get_previous_count(model_name) + changed).to eq(to_klass(model_name).count)
end

step ':model_finder :have標籤 :tag_name' do |instance, have, tag_name|
  expect(instance.tag_list.include?(tag_name.to_s.downcase)).to eq(have)
end
