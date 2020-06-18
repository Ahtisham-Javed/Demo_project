Rails.application.routes.draw do

  get 'shipments/index'
  get 'comments/new'
  root 'products#home'

  # devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :products do
    get "current_user_products", on: :collection
    resources :comments, only: [:create, :edit, :update, :destroy]
  end
  
  resources :shipments, except: [:new, :show]
  
end
