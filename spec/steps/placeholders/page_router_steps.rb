placeholder :page_router do
  match /到後台/ do
    Bdd::AdminRouter
  end

  match /瀏覽/ do
    Bdd::ApplicationRouter
  end

  match /打API/ do
    Bdd::ApiRouter
  end
end
