placeholder :role_class do
  match /(user|使用者|管理者)/ do
    User
  end
end
