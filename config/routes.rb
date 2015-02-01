require 'sidekiq/web'
Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  devise_for :users
  get "/authorizations/:provider/callback", to: "authorizations#callback"
  get "/authorizations/failure" => "authorizations#failue", as: :auth_failure
  Setting.omniauth.providers.keys.each do |provider|
    get "/authorizations/#{provider}", as: "auth_#{provider}"
  end

  root to: "base#index"

  namespace :admin do
    root to: "base#index"
  end
end
