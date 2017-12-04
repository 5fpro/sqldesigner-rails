step ':user_role 登入' do |role|
  signin_user(role) if role.is_a?(User)
end

step ':model_finder 登入' do |role|
  signin_user(role) if role.is_a?(User)
end
