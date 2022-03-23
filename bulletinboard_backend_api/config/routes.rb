Rails.application.routes.draw do
  resources :users
  resources :posts

  post 'login', to: 'users#login'
end
