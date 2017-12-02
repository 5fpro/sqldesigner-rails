placeholder :request_method do
  match /(GET|get|POST|post|PUT|put|DELETE|delete)/ do |method|
    method.to_s.downcase
  end
end
