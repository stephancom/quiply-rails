Rails.application.routes.draw do
  root 'users#index'
  resources :orders
  resources :users
end
