require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do

  mount Redactor2Rails::Engine => '/redactor2_rails'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    confirmations: 'users/confirmations',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    unlocks: 'users/unlocks'
  }
  devise_for :administrators, controllers: {
    sessions: 'administrators/sessions'
  }
  get '/version', to: 'base#version' unless Rails.env.production?
  get '/authorizations/:provider/callback', to: 'authorizations#callback'
  get '/authorizations/failure' => 'authorizations#failue', as: :auth_failure
  Setting.omniauth.providers.keys.each do |provider|
    get "/authorizations/#{provider}", as: "auth_#{provider}"
  end

  root to: 'base#index'
  get '/robots.txt', to: 'base#robots', defaults: { format: 'text' }

  namespace :admin do
    root to: 'base#index', as: :root
    get '/examples', to: 'base#examples', as: :examples
    get '/error', to: 'base#error', as: :error
    resource  :account, only: [:show, :update]
    resources :users
    resources :administrators
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
    match '(*not_found)', to: 'base#respond_404', via: :all
  end

  # error pages
  match '/400', to: 'errors#not_found', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all

  authenticate :administrator, lambda { |a| a.present? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  # must put this line to bottom of routes.rb
  match '(*not_found)', to: 'errors#not_found', via: :all
end
