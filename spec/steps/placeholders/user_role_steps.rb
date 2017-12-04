placeholder :user_role do
  match /(user|使用者)/ do
    @role_user = create(:user) unless @role_user && User.exists?(@role_user.id)
    @role_user
  end

  match /管理者/ do
    @role_admin = create(:user, :admin) unless @role_admin && User.where(admin: true).exists?(@role_admin.id)
    @role_admin
  end
end
