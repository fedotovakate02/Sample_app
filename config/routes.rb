Rails.application.routes.draw do
  get 'sessions/new'
  #get 'signup', to: 'users#new'
  root 'static_pages#home'
  get 'static_pages/help'
  get 'static_pages/about'
  get 'static_pages/contact'
 
  resources :users
  resources :sessions, only: [:new, :create]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
