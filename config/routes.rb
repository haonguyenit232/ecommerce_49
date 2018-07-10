Rails.application.routes.draw do
  get "products/index"
  get "products/show"
  root "static_pages#home"
  get "/fetch_items", to: "products#filter_product", as: "fetch_items"
  resources :categories
  devise_for :users, skip: :sessions,
    controllers: {registrations: "users",
                  sessions: "sessions",
                  omniauth_callbacks: "omniauth_callbacks"}
  as :user do
    get "login", to: "sessions#new", as: :new_user_session
    post "login", to: "sessions#create", as: :user_session
    delete "logout", to: "devise/sessions#destroy", as: :destroy_user_session
  end

  resources :products, only: %i(index show) do
    resources :comments
    resources :ratings, only: :create
  end
  resources :orders, except: :update do
    resources :order_details, only: :index
  end

  namespace :admin do
    root "static_pages#home"
    resources :users
    resources :categories
    resources :products do
      post 'import', on: :collection
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
