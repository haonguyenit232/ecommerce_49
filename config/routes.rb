Rails.application.routes.draw do

  get "products/index"
  get "products/show"

  root "static_pages#home"
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  get "/profile", to: "admin/users#show"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users, except: %i(index)
  resources :carts, only: %(index)
  resources :items
  resources :order_details
  resources :orders
  resources :categories
  resources :search_products, only: :index
  resources :products
  namespace :admin do
    root "users#index"
    resources :users
    resources :categories do
      resources :products
    end
    resources :products
  end
  resources :carts, only: :index
  get "add_cart/:id_product", to: "carts#add_cart", as: :add_cart
  get "remove_cart/:id_product", to: "carts#remove_cart", as: :remove_cart
  put "update_hard_cart", to: "carts#update_hard_cart", as: :update_hard_cart
end
