Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :kinds
  resources :auths, only: [:create]
  
  resources :contacts do
    resource :kind, only: [:show]
    resource :kind, only: [:show], path: 'relationships/kind'

    resource :phones, only: [:show]
    resource :phone, only: [:create, :update, :destroy]
    resource :phones, only: [:show], path: 'relationships/phones'
    resource :phone, only: [:create, :update, :destroy], path: 'relationships/phone'

    resource :address, only: [:show, :create, :update, :destroy]
    resource :address, only: [:show, :create, :update, :destroy], path: 'relationships/address'
  end
end
