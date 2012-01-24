NetspireAdmin::Application.routes.draw do
  devise_for :admin

  devise_scope :admin do
    get '/logout' => 'devise/sessions#destroy', :as => :destroy_admin_session
  end

  authenticated :admin do
    root :to => 'private/dashboard#index'
  end

  unauthenticated do
    as :admin do
      root :to => 'devise/sessions#new'
    end
  end
end
