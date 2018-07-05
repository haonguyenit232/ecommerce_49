Rails.application.routes.draw do
  get "products/index"
  get "products/show"
  root "static_pages#home"
  get "/fetch_items", to: "products#filter_product", as: "fetch_items"
  resources :search_products, only: :index
  resources :categories
  devise_for :users
  resources :products, only: %i(index show) do
    resources :comments
    resources :ratings, only: :create
  end
  resources :orders do
    resources :order_details, only: :index
  end

  namespace :admin do
    root "static_pages#home"
    resources :categories do
      resources :products
    end
    resources :products
    resources :orders do
      resources :order_details
    end
  end
  resources :carts, only: :index
  get "add_cart/:id_product", to: "carts#add_cart", as: :add_cart
  get "remove_cart/:id_product", to: "carts#remove_cart", as: :remove_cart
  put "orders/:id_order", to: "orders#cancel", as: :cancel
  put "update_hard_cart", to: "carts#update_hard_cart", as: :update_hard_cart
end
