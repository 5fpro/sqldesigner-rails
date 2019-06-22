Rails.application.routes.draw do
  constraints Tyr.config.api_constraints do
    scope module: 'api' do
      root to: 'base#index', as: :api_root
      get '/error', to: 'base#error'
    end
  end

  namespace :admin do
    root to: 'base#index'
    resources :users
    resources :categories do
      member do
        get :revisions
        post :restore
      end
    end
  end

  root to: 'erds#new'

  devise_scope :user do
    get '/logout' => 'devise/sessions#destroy', as: :user_logout
  end

  mount Tyr::Engine => '/'

  resources :erds do
    member do
      get :revisions
    end
  end

  instance_exec(&Tyr.catch_not_found_route)
end
