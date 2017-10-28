step ':user 登入' do |user|
  @current_user ||= user
  signin_user(@current_user)
end

placeholder :user do
  match /user/ do
    create(:user)
  end

  match /管理者/ do
    create(:user, :admin)
  end
end
