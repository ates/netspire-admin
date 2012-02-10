NetspireAdmin::Application.routes.draw do
  devise_for :admin
  devise_for :account

  devise_scope :admin do
    get '/logout' => 'devise/sessions#destroy', :as => :destroy_admin_session
  end

  authenticated :admin do
    root :to => 'private/dashboard#index'

    namespace :private do
      match '/dashboard', :to => 'dashboard#index', :as => :dashboard
      match '/profile', :to => 'dashboard#profile', :as => :profile

      resources :accounts do
        member do
          get :transactions
        end
      end
    end
  end

  authenticated :account do
    root :to => 'dashboard#index'
  end

  unauthenticated do
    as :admin do
      root :to => 'devise/sessions#new'
    end
  end
end
