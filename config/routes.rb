SqldesignerRails::Application.routes.draw do
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
