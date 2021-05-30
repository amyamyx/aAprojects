Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:create, :new, :show]
  resource :session, only: [:create, :new, :destroy]
  resource :tracks, except: [:index, :new]
  
  resources :bands do
    resources :albums, only: [:new]
  end

  resources :albums, except: [:index, :new] do
    resource :tracks, only: [:new]
  end
end
