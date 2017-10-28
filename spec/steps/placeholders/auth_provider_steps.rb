placeholder :auth_provider do
  match /(facebook|github|google)/ do |provider|
    provider = provider.downcase
    provider = 'google_oauth2' if provider == 'google'
    provider
  end
end
