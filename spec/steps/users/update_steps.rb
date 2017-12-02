step ':model_finder 設為未驗證' do |instance|
  instance.update(confirmed_at: nil)
end
