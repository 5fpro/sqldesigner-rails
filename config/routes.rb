SqldesignerRails::Application.routes.draw do

  match '/auth/:provider/callback', :to => 'sessions#create'
  match '/auth/failure' => 'sessions#failure'
  match '/auth/facebook', :as => :facebook_login

  devise_for :users

  root :to => 'high_voltage/pages#show', :id => 'welcome'
  namespace :backend do
    resources :rails, :only => [:index] do
      collection do
        get "list"
        post "save"
        get "load"
        get "import"
      end
    end
  end

end
