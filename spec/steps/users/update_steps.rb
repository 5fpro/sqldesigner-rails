step ':model_finder 設為未驗證' do |user|
  user.update(confirmed_at: nil)
end

