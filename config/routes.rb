Rails.application.routes.draw do
  root 'cohorts#show'

  get 'cohorts/show'
  resources :orders
  resources :users
end
