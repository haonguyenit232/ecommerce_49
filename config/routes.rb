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
    resources :users, except: %i(show)
    resources :categories do
      resources :products
    end
    resources :products
  end
end
