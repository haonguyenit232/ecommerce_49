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
  resources :categories
  resources :search_products, only: :index
  resource :cart, only: :show
  resources :oder_details, only: %i(create update destroy)
  resources :products do
    resources :comments
  end
  namespace :admin do
    root "users#index"
    resources :users, except: %i(show)
    resources :categories do
      resources :products
    end
    resources :products
  end
end
