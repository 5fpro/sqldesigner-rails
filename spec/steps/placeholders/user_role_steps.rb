placeholder :user_role do
  match /(user|使用者)/ do
    @role_user = create(:user) unless @role_user && User.exists?(@role_user.id)
    @role_user
  end

  match /(超級管理者)/ do
    @role_admin = create(:administrator, :root) unless @role_admin && Administrator.exists?(@role_admin.id)
    @role_admin
  end

  match /(admin|管理者)/ do
    @role_admin = create(:administrator) unless @role_admin && Administrator.exists?(@role_admin.id)
    @role_admin
  end
end
