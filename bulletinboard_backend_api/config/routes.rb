Rails.application.routes.draw do
  resources :users do
    resources :posts
  end

  post 'login', to: 'users#login'
  get 'all_posts', to: 'posts#all_posts'
end
