Rails.application.routes.draw do
  match "*path" => "options_request#preflight", via: :options

  resources :login, only: [:create]
  resources :users, only: [:show]
end
