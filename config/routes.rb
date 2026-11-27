Rails.application.routes.draw do
  root "home#index"

  resources :products, only: [ :index, :show ]
  resources :categories, only: [ :show ]

  get "cart", to: "cart#index", as: :cart
  post "cart/add", to: "cart#add", as: :add_to_cart
  patch "cart/update", to: "cart#update", as: :update_cart
  delete "cart/remove", to: "cart#remove", as: :remove_from_cart

  namespace :admin do
    get "login", to: "sessions#new"
    post "login", to: "sessions#create"
    delete "logout", to: "sessions#destroy"
    get "dashboard", to: "dashboard#index"

    resources :products
    resources :categories, except: [ :show ]
    resources :pages, only: [ :index, :edit, :update ]
  end
end
