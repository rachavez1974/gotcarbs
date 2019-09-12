Rails.application.routes.draw do

  get 'addresses/new'
  get 'address/new'
  resources :users, except: [:new, :create]
  resources :addresses

  namespace :admin do
    # root to: '/dashboard'
    resources :users
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
end
