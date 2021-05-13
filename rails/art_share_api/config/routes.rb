# == Route Map
#
#                    Prefix Verb   URI Pattern                                                      Controller#Action
#             user_artworks GET    /users/:user_id/artworks(.:format)                               artworks#index
#             user_comments GET    /users/:user_id/comments(.:format)                               comments#index
#          user_collections GET    /users/:user_id/collections(.:format)                            collections#index
#                     users GET    /users(.:format)                                                 users#index
#                           POST   /users(.:format)                                                 users#create
#                      user GET    /users/:id(.:format)                                             users#show
#                           PATCH  /users/:id(.:format)                                             users#update
#                           PUT    /users/:id(.:format)                                             users#update
#                           DELETE /users/:id(.:format)                                             users#destroy
#          artwork_comments GET    /artworks/:artwork_id/comments(.:format)                         comments#index
#          favorite_artwork POST   /artworks/:id/favorite(.:format)                                 artworks#favorite
#        unfavorite_artwork POST   /artworks/:id/unfavorite(.:format)                               artworks#unfavorite
#              like_artwork POST   /artworks/:id/like(.:format)                                     artworks#like
#            unlike_artwork POST   /artworks/:id/unlike(.:format)                                   artworks#unlike
#                  artworks POST   /artworks(.:format)                                              artworks#create
#                   artwork GET    /artworks/:id(.:format)                                          artworks#show
#                           PATCH  /artworks/:id(.:format)                                          artworks#update
#                           PUT    /artworks/:id(.:format)                                          artworks#update
#                           DELETE /artworks/:id(.:format)                                          artworks#destroy
#    favorite_artwork_share POST   /artwork_shares/:id/favorite(.:format)                           artwork_shares#favorite
#  unfavorite_artwork_share POST   /artwork_shares/:id/unfavorite(.:format)                         artwork_shares#unfavorite
#            artwork_shares POST   /artwork_shares(.:format)                                        artwork_shares#create
#             artwork_share DELETE /artwork_shares/:id(.:format)                                    artwork_shares#destroy
#              like_comment POST   /comments/:id/like(.:format)                                     comments#like
#            unlike_comment POST   /comments/:id/unlike(.:format)                                   comments#unlike
#                  comments POST   /comments(.:format)                                              comments#create
#                   comment PATCH  /comments/:id(.:format)                                          comments#update
#                           PUT    /comments/:id(.:format)                                          comments#update
#                           DELETE /comments/:id(.:format)                                          comments#destroy
#    collection_artwork_add POST   /collection/:collection_id/artworks/:artwork_id/add(.:format)    collections#add
# collection_artwork_remove DELETE /collection/:collection_id/artworks/:artwork_id/remove(.:format) collections#remove
#       collection_artworks GET    /collection/:collection_id/artworks(.:format)                    artworks#index
#          collection_index POST   /collection(.:format)                                            collection#create
#                collection GET    /collection/:id(.:format)                                        collection#show
#                           DELETE /collection/:id(.:format)                                        collection#destroy

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:index, :show, :create, :update, :destroy] do
    resources :artworks, only: [:index]
    resources :comments, only: [:index]
    resources :collections, only: [:index]
  end

  resources :artworks, only: [:show, :create, :update, :destroy] do
    resources :comments, only: [:index]

    member do
      post :favorite, to: "artworks#favorite", as: :favorite
      post :unfavorite, to: "artworks#unfavorite", as: :unfavorite
      post :like, to: "artworks#like", as: :like
      post :unlike, to: "artworks#unlike", as: :unlike
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

  resources :collections, only: [:create, :show, :destroy] do
    resources :artworks, only: [:index] do
      post :add, to: "collections#add_artwork", as: :add_artwork
      delete :remove, to: "collections#remove_artwork", as: :remove_artwork
    end
  end
end
