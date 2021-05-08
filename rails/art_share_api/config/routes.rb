# == Route Map
#
#           Prefix Verb   URI Pattern                              Controller#Action
#    user_artworks GET    /users/:user_id/artworks(.:format)       artworks#index
#    user_comments GET    /users/:user_id/comments(.:format)       comments#index
#            users GET    /users(.:format)                         users#index
#                  POST   /users(.:format)                         users#create
#             user GET    /users/:id(.:format)                     users#show
#                  PATCH  /users/:id(.:format)                     users#update
#                  PUT    /users/:id(.:format)                     users#update
#                  DELETE /users/:id(.:format)                     users#destroy
# artwork_comments GET    /artworks/:artwork_id/comments(.:format) comments#index
#         artworks POST   /artworks(.:format)                      artworks#create
#          artwork GET    /artworks/:id(.:format)                  artworks#show
#                  PATCH  /artworks/:id(.:format)                  artworks#update
#                  PUT    /artworks/:id(.:format)                  artworks#update
#                  DELETE /artworks/:id(.:format)                  artworks#destroy
#   artwork_shares POST   /artwork_shares(.:format)                artwork_shares#create
#    artwork_share DELETE /artwork_shares/:id(.:format)            artwork_shares#destroy
#         comments POST   /comments(.:format)                      comments#create
#          comment PATCH  /comments/:id(.:format)                  comments#update
#                  PUT    /comments/:id(.:format)                  comments#update
#                  DELETE /comments/:id(.:format)                  comments#destroy

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:index, :show, :create, :update, :destroy] do
    resources :artworks, only: [:index]
    resources :comments, only: [:index]
  end

  resources :artworks, only: [:show, :create, :update, :destroy] do
    resources :comments, only: [:index]

    member do
      post :favorite, to: "artworks#favorite", as: :favorite
      post :unfavorite, to: "artworks#unfavorite", as: :unfavorite
    end
  end

  resources :artwork_shares, only: [:create, :destroy] do
    member do
      post :favorite, to: "artwork_shares#favorite", as: :favorite
      post :unfavorite, to: "artwork_shares#unfavorite", as: :unfavorite
    end
  end
  
  resources :comments, only: [:create, :update, :destroy] do
    member do
      post :like, to: "comments#like", as: :like
      post :unlike, to: "comments#unlike", as: :unlike
    end
  end
end
