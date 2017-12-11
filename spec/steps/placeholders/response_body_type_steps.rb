# map to BodyExtractor's type_name
placeholder :response_body_type do
  match /Meta Title/ do
    :meta_title
  end

  match /Meta Desc/ do
    :meta_desc
  end

  match /Meta Url/ do
    :meta_url
  end

  match /Flash Message/ do
    :flash_message
  end

  match /頁面/ do
    :body
  end
end
