placeholder :page_caller do
  match /使用者頁面/ do
    ->(u) { "/users/#{u.id}" }
  end

  match /使用者編輯頁面/ do
    ->(u) { "/users/#{u.id}/edit" }
  end
end
