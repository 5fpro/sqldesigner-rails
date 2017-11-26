step '前往 :page' do |page|
  get page
end

step '打 :request_method 到 :page' do |request_method, page, *args|
  body = args[0]
  options = params = body.present? ? JSON.parse(body) : {}
  options = { params: params } unless params.key?(:params)
  public_send request_method, page, options
end
