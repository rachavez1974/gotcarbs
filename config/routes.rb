Rails.application.routes.draw do

  resources :users, except: [:new]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'static_pages#home'
  get '/signup', to: 'users#new'
  
  #custom sessions routes
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  post '/logout',  to: 'sessions#destroy'

  get '/about', to: 'static_pages#about', as: 'about'
  get '/menus', to: 'static_pages#menus', as: 'menus'
  get '/contact', to: 'static_pages#contact', as: 'contact'
end
