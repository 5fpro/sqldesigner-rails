placeholder :count_changed do
  match /[\+\-][0-9]+/, &:to_i

  match /不變/ do |_count|
    0
  end
end
