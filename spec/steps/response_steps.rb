step '頁面回應 :http_status' do |http_status|
  if http_status.is_a?(Integer)
    expect(response.status).to eq(http_status)
  end
end

step '回應內容:is_matched \':matched_content\'' do |is_matched, matched_content|
  if is_matched == '不含'
    expect(response.body).not_to include(matched_content)
  elsif is_matched.index('含')
    expect(response.body).to include(matched_content)
  end
end

step '回應格式為 :format' do |format|
  expect(response.headers['Content-Type']).to include(format.to_s.downcase)
end

step '頁面 轉跳(至 ):page' do |path|
  if path.present?
    expect(response).to redirect_to(path)
  else
    expect(response).to be_redirect
  end
end

step ':response_body_type :string_matcher( ):str_value' do |body_type, matcher_bind_str, value|
  str = BodyExtractor.new(response.body).extract(body_type)
  eval(matcher_bind_str)
end

placeholder :str_value do
  match /.+/ do |str|
    str
  end

  match /.{0}/ do
    ''
  end
end
