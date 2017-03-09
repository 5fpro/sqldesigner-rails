module RequestClient
  def signout_user
    delete '/users/sign_out'
    @current_user = nil
  end

  def signin_user(user = nil)
    user ||= create(:admin_user)
    post '/users/sign_in', params: { user: { email: user.email, password: user.password } }
    @current_user = user if response.status == 302
  end

  def current_user
    @current_user
  end

  def file_data
    fixture_file_upload('spec/fixtures/5fpro.png', 'image/png')
  end
end
