Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "bands#index"
  
  resources :users, only: [:create, :new, :show] do
    get 'activate', to: 'users#activate', as: :activate, on: :collection
  end

  resource :session, only: [:create, :new, :destroy]
  
  resources :bands do
    resources :albums, only: [:new]
  end
  
  resources :albums, except: [:index, :new] do
    resources :tracks, only: [:new]
  end

  resources :tracks, except: [:index, :new] do
    resources :notes, only: [:create]
  end
  
  resources :notes, only: [:destroy]
end
