Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  root to: 'notes#index'

  resources :notes
  resources :users, only: [:index]
  resources :relationships, only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]

end
