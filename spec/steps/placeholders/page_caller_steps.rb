placeholder :page_caller do
  match /後台使用者頁面/ do
    ->(u) { "/admin/users/#{u.id}" }
  end

  match /後台使用者編輯頁面/ do
    ->(u) { "/admin/users/#{u.id}/edit" }
  end
end
