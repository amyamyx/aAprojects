# == Route Map
#
# Prefix Verb URI Pattern         Controller#Action
#   cats GET  /cats(.:format)     cats#index
#    cat GET  /cats/:id(.:format) cats#show

Rails.application.routes.draw do
  resources :cats, only: [:index, :show]
end
