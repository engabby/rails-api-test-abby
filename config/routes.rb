# config/routes.rb
Rails.application.routes.draw do
  resources :lists
  resources :cards
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
  get 'users', to: 'users#show'
  post 'lists/assign_member/:id', to: 'lists#assign_member'
end
