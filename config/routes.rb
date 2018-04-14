Rails.application.routes.draw do
  root to: 'base#index'

  mount Tyr::Engine => '/'

  namespace :admin do
    resources :users
    resources :categories do
      member do
        get :revisions
        post :restore
      end
    end
  end

  instance_exec(&Tyr.catch_not_found_route)
end
