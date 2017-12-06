step ':page_router :page' do |router, page|
  get router.build_url(page)
end

def send_request_by_router(router, request_method, page, body)
  path = router.build_url(page)
  options = parse_body(body)
  options = router.build_env(options)
  public_send request_method, path, options
end

step ':page_router :request_method 到 :page' do |router, request_method, page, *args|
  send_request_by_router(router, request_method, page, args[0])
end

step ':page_router :request_method :model_finder 的 :page_caller' do |router, request_method, instance, page_caller, *args|
  page = page_caller.call(instance)
  send_request_by_router(router, request_method, page, args[0])
end

step '跟隨頁面轉跳' do
  follow_redirect!
end
