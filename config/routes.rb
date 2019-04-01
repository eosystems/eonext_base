Rails.application.routes.draw do
  resources :login, only: [:create]
  resources :users, only: [:show]
end
