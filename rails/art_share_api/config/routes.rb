# == Route Map
#
#         Prefix Verb   URI Pattern                        Controller#Action
#  user_artworks GET    /users/:user_id/artworks(.:format) artworks#index
#          users GET    /users(.:format)                   users#index
#                POST   /users(.:format)                   users#create
#           user GET    /users/:id(.:format)               users#show
#                PATCH  /users/:id(.:format)               users#update
#                PUT    /users/:id(.:format)               users#update
#                DELETE /users/:id(.:format)               users#destroy
#       artworks POST   /artworks(.:format)                artworks#create
#        artwork GET    /artworks/:id(.:format)            artworks#show
#                PATCH  /artworks/:id(.:format)            artworks#update
#                PUT    /artworks/:id(.:format)            artworks#update
#                DELETE /artworks/:id(.:format)            artworks#destroy
# artwork_shares POST   /artwork_shares(.:format)          artwork_shares#create
#  artwork_share DELETE /artwork_shares/:id(.:format)      artwork_shares#destroy

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:index, :show, :create, :update, :destroy] do
    resources :artworks, only: [:index]
  end
  resources :artworks, only: [:show, :create, :update, :destroy]
  resources :artwork_shares, only: [:create, :destroy]
end
