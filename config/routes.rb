require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users
  get '/authorizations/:provider/callback', to: 'authorizations#callback'
  get '/authorizations/failure' => 'authorizations#failue', as: :auth_failure
  Setting.omniauth.providers.keys.each do |provider|
    get "/authorizations/#{provider}", as: "auth_#{provider}"
  end

  root to: 'base#index'
  get '/robots.txt', to: 'base#robots', defaults: { format: 'text' }

  namespace :admin do
    root to: 'base#index', as: :root
    resources :users
    resources :categories do
      member do
        get :revisions
        post :restore
      end
    end
  end

  namespace :api do
    root to: 'base#index', as: :root
    match '/error', to: 'base#error', via: :all
    match '*not_found', to: 'base#respond_404', via: :all
  end

  # error pages
  match '/400', to: 'errors#not_found', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all

  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  # must put this line to bottom of routes.rb
  match '*not_found', to: 'errors#not_found', via: :all
end
