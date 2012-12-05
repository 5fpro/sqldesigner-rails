SqldesignerRails::Application.routes.draw do

  match '/auth/:provider/callback', :to => 'sessions#create'
  match '/auth/failure' => 'sessions#failure'
  match '/auth/facebook', :as => :facebook_login

  devise_scope :user do
    get "/logout" => "devise/sessions#destroy", :as => :user_logout
  end
  devise_for :users

  resources :erds do
    member do
      get :revisions
    end
  end
  root :to => "erds#new"

end
