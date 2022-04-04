Rails.application.routes.draw do
  resources :users do
    resources :posts
  end

  post 'login', to: 'users#login'
  get 'search', to: 'users#search'
  get 'post_search', to: 'posts#post_search'
  get 'all_posts', to: 'posts#all_posts'
  get 'admin_show/:id', to: 'posts#admin_show'
  put 'admin_update/:id', to: 'posts#admin_update'
  post 'csv_create', to: 'posts#csv_create'
  post 'change_password/:id', to: 'users#change_password'
  post 'find_user', to: 'password_reset#find_user'
  post 'update_password', to: 'password_reset#update_password'
end
