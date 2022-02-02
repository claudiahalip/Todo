Rails.application.routes.draw do
  
    root "tasks#index"

    post '/login', to: 'session#create'
    delete '/logout', to: 'session#destroy'
    get '/logged_in', to: 'session#is_logged_in'
    
    resources :users, only: [:index, :create]
    resources :tasks
end
