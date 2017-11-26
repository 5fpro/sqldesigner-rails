placeholder :page_caller do
  match /後台使用者頁面/ do
    ->(u) { "/admin/users/#{u.id}" }
  end

  match /後台使用者編輯頁面/ do
    ->(u) { "/admin/users/#{u.id}/edit" }
  end
end

step '前往 :model_finder 的 :page_caller' do |model_finder, page_caller|
  get page_caller.call(model_finder)
end
