Rails.application.routes.draw do
  # get 'documents/index'
  # get 'documents/show'
  # get 'documents/edit'
  # get 'documents/new'
  resources :activities
  resources :links
  resources :documents
  devise_for :users
  get 'home/page'
  root 'home#page'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
