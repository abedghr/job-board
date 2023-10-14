Rails.application.routes.draw do
  namespace :api do
    resources :users
    resources :applications
    resources :posts
    resources :admin_posts
    resources :admin_applications
    post 'register', to: 'token#register'
    post 'login', to: 'token#login'
  end
end
