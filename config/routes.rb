Rails.application.routes.draw do
  # resources :posts
  # resources :users
  post 'api/register', to: 'users#register_user'
  post 'api/login', to: 'users#login_user'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
