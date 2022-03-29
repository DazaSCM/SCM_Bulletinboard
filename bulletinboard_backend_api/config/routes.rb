Rails.application.routes.draw do
  resources :users do
    resources :posts
  end

  post 'login', to: 'users#login'
  get 'search', to: 'users#search'
  get 'all_posts', to: 'posts#all_posts'
  post 'change_password/:id', to: 'users#change_password'
end
