Rails.application.routes.draw do

  
  resources :cart_items
  resources :carts, only: [:show, :destroy]
  resources :ordered_items, only: [:create, :destroy]
  get '/add_one/:id', to: 'cart_items#add_one', as: 'add_to_cart'
  get '/minus_one/:id', to: 'cart_items#minus_one', as: 'minus_from_cart'
  resources :orders
  resources :users, except: [:new, :create]
  resources :addresses
  

  namespace :admin do
    # root to: '/dashboard'
    resources :items
    get 'searchitem', to: 'items#search_item'
    get 'search', to: 'items#search'
    resources :users do
      resources :addresses
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'static_pages#home'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  
  #custom sessions routes
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  post '/logout',  to: 'sessions#destroy'
  get '/auth/facebook/callback' => 'sessions#create'

  get '/about', to: 'static_pages#about', as: 'about'
  get '/menus', to: 'static_pages#menus', as: 'menus'
  get '/contact', to: 'static_pages#contact', as: 'contact'
  get '/menu', to: 'menus#show'
end
