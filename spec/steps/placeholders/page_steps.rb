placeholder :page do
  match /首頁/ do
    '/'
  end

  match /\/.+/ do |page|
    page
  end
end
