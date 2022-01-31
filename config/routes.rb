Rails.application.routes.draw do
  
  root "tasks#index"
  resources :users, only: [:index, :create]
  resources :tasks
end
