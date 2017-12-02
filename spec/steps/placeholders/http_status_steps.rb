placeholder :http_status do
  match /正常/ do
    200
  end

  match /\d+/, &:to_i
end
