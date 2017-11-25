step '使用者已登入' do
  get '/users/sign_in'
  expect(response).to be_redirect
end

step '使用者未登入' do
  get '/users/sign_in'
  expect(response).to be_success
end

