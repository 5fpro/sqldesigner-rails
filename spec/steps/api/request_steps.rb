step '前往API :page' do |page|
  get convert_to_api_path(page)
end

step '打API :request_method 到 :page' do |request_method, page, *args|
  body = args[0]
  params = body.present? ? JSON.parse(body) : {}
  params = { params: params } unless params.key?(:params)
  params[:xhr] = true
  public_send request_method, convert_to_api_path(page), params
end

def convert_to_api_path(path)
  "/api/#{path}"
end
