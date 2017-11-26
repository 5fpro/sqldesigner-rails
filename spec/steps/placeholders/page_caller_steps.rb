placeholder :page_caller do
  match /使用者頁面/ do
    ->(u) { "/users/#{u.id}" }
  end

  match /使用者編輯頁面/ do
    ->(u) { "/users/#{u.id}/edit" }
  end

  match /分類頁面/ do
    ->(category) { "/categories/#{category.id}" }
  end

  match /分類編輯頁面/ do
    ->(category) { "/categories/#{category.id}/edit" }
  end

  match /分類版本記錄頁面/ do
    ->(category) { "/categories/#{category.id}/revisions" }
  end
end
