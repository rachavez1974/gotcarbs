Rails.application.routes.draw do

  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
  get '/about', to: 'static_pages#about', as: 'about'
  get '/menus', to: 'static_pages#menus', as: 'menus'
  get '/contact', to: 'static_pages#contact', as: 'contact'
end
