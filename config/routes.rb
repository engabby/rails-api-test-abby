# config/routes.rb
Rails.application.routes.draw do
  resources :lists
  resources :cards
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
end
