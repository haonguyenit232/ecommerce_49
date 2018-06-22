Rails.application.routes.draw do

  get "products/index"
  get "products/show"

  root "static_pages#home"
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  get "/profile", to: "admin/users#show"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users, except: %i(destroy index)
  resources :search_products, only: :index
  resources :products, only: :index
  resource :cart, only: :show
  resources :oder_details, only: %i(create update destroy)
  namespace :admin do
    root "users#index"
    resources :users
  end
  resources :categories
  resources :products
  resources :ratings, only: %i(create update)
end
