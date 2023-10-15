Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api do
    resources :users
    resources :applications
    resources :posts
    resources :admin_posts
    resources :admin_applications
    post 'register', to: 'token#register'
    post 'login', to: 'token#login'
    post 'refresh', to: 'token#refresh'
  end
end
