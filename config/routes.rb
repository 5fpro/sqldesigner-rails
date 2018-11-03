Rails.application.routes.draw do
  root to: 'base#index'

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

  mount Tyr::Engine => '/'

  instance_exec(&Tyr.catch_not_found_route)
end
