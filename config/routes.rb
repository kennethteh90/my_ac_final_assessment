Rails.application.routes.draw do
  devise_for :users

  root to: 'notes#index'

  resources :notes
  resources :users, only: [:index]
  resources :relationships, only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]

end
