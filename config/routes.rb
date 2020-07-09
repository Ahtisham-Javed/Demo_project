Rails.application.routes.draw do

  root 'products#index'
 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :products do
    get "current_user_products", on: :collection
    
    resources :comments, only: [:create, :edit, :update, :destroy]
  end

  resources :shipments, except: [:new, :show]

  scope '/checkout' do 
    post 'create', to: "checkout#create", as: 'checkout_create'
    get 'cancel', to: "checkout#cancel", as: 'checkout_cancel'
    get 'success', to: "checkout#success", as: 'checkout_success'
  end

end
