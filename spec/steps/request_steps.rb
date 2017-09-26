step '前往 :page' do |page|
  get page
end

step '前往 :model_finder 的 :page_caller' do |model_finder, page_caller|
  get page_caller.call(model_finder)
end

step '對 :page 打 :req_method' do |page, req_method|
  public_send(req_method, page)
end

placeholder :req_method do
  match /(POST|post|PUT|put|DELETE|delete)/ do |method|
    method.to_s.downcase
  end
end
