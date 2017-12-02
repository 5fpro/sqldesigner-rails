placeholder :user_role do
  match /user/ do
    create(:user)
  end

  match /管理者/ do
    create(:user, :admin)
  end
end
