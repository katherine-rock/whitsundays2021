Rails.application.routes.draw do
  resources :activities
  resources :links
  resources :documents
  resources :posts
  devise_for :users
  get 'home/page'
  root 'home#page'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
