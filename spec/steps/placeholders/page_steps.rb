placeholder :page do
  match /API首頁/ do
    '/api'
  end

  match /後台新增使用者頁面/ do
    '/admin/users/new'
  end

  match /首頁/ do
    '/'
  end

  match /\/.+/ do |page|
    page
  end
end
