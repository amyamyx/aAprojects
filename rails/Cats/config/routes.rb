# == Route Map
#
#  Prefix Verb URI Pattern         Controller#Action
#    cats GET  /cats(.:format)     cats#index
#         POST /cats(.:format)     cats#create
# new_cat GET  /cats/new(.:format) cats#new
#     cat GET  /cats/:id(.:format) cats#show

Rails.application.routes.draw do
  resources :cats, only: [:index, :show, :new, :create]
end
