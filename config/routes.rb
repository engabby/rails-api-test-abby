# config/routes.rb
Rails.application.routes.draw do
  resources :lists
  resources :cards
  resources :comments
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
  get 'users', to: 'users#show'
  post 'lists/:id/assign_member', to: 'lists#assign_member'
  post 'lists/:id/unassign_member', to: 'lists#unassign_member'
end
