step ':role_class 已登入' do |klass|
  get "/#{klass.to_s.underscore.pluralize}/sign_in"
  expect(response).to be_redirect
end

step ':role_class 未登入' do |klass|
  get "/#{klass.to_s.underscore.pluralize}/sign_in"
  expect(response).to be_success
end
