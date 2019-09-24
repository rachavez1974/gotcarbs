Rails.application.routes.draw do
  
  
  resources :orders, only: [:create, :show, :index]
  resources :carts, only: [:show, :destroy]
  resources :cart_items
  get '/increment_cartitem/:id', to: 'cart_items#add_one', as: 'add_to_cart'
  get '/decrement_cartitem/:id', to: 'cart_items#minus_one', as: 'minus_from_cart'
  resources :users, except: [:new, :create]
  resources :addresses
  

  namespace :admin do
    root to: 'dashboard#home'
    get '/support', to: "dashboard#support"
    resources :items
    #display forms views only
    get 'searchitem', to: 'items#search_item'
    get 'showitem', to: 'items#search'
    get 'searchuser', to: 'users#search_user'
    get 'showuser', to: 'users#search'
    resources :users do
      resources :addresses
    end

    resources :orders, only: [:show, :index, :destroy]
    resources :ordered_items, only: [:destroy]
    get '/add_to_order/:id', to: 'ordered_items#add_one', as: 'add_to_order'
    get '/minus_from_order/:id', to: 'ordered_items#minus_one', as: 'minus_from_order'
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
