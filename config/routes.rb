Rails.application.routes.draw do
  
  root "tasks#index"

  post '/login', to: 'session#create'
  delete '/logout', to: 'session#destroy'
  
  resources :users, only: [:index, :create]
  resources :tasks
end
