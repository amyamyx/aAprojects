# == Route Map
#
#                     Prefix Verb  URI Pattern                                Controller#Action
#                       cats GET   /cats(.:format)                            cats#index
#                            POST  /cats(.:format)                            cats#create
#                    new_cat GET   /cats/new(.:format)                        cats#new
#                   edit_cat GET   /cats/:id/edit(.:format)                   cats#edit
#                        cat GET   /cats/:id(.:format)                        cats#show
#                            PATCH /cats/:id(.:format)                        cats#update
#                            PUT   /cats/:id(.:format)                        cats#update
# approve_cat_rental_request POST  /cat_rental_requests/:id/approve(.:format) cat_rental_requests#approve
#    deny_cat_rental_request POST  /cat_rental_requests/:id/deny(.:format)    cat_rental_requests#deny
#        cat_rental_requests POST  /cat_rental_requests(.:format)             cat_rental_requests#create
#     new_cat_rental_request GET   /cat_rental_requests/new(.:format)         cat_rental_requests#new

Rails.application.routes.draw do
  resources :cats, only: [:index, :show, :new, :create, :edit, :update]
  resources :cat_rental_requests, only: [:new, :create] do
    member do
      post :approve, to: "cat_rental_requests#approve", as: :approve
      post :deny, to: "cat_rental_requests#deny", as: :deny
    end
  end

  resources :users, only: [:create, :new]
  resource :session, only: [:create, :new, :destroy]
end
