step ':role_class 登出' do |klass|
  delete "/#{klass.to_s.underscore.pluralize}/sign_out"
end
