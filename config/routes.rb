Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get 'users/sign_out', to: 'devise/sessions#destroy', as: 'logout'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :users
  # Defines the root path route ("/")
  root 'users#index'
end
