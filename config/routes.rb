Rails.application.routes.draw do
  # devise_for :users
  root 'home#index'

  # Authentication routes
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'signup', to: 'users#new'
  resources :users, only: [:create, :show]

  resources :products, only: [:index, :show]
  resources :cart_items, only: [:create, :update, :destroy]
  resource :cart, only: [:show]
  resources :orders, only: [:index, :show, :new, :create]

  namespace :admin do
    resources :products
    resources :orders, only: [:index, :show, :update]
    resources :categories
  end
end
