step '前往 :page' do |page|
  get page
end

step '前往 :model_finder 的 :page_caller' do |model_finder, page_caller|
  get page_caller.call(model_finder)
end

step '打 :request_method 到 :page' do |request_method, page, *args|
  body = args[0]
  options = params = body.present? ? JSON.parse(body) : {}
  options = { params: params } unless params.key?(:params)
  public_send request_method, page, options
end
