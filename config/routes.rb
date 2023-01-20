Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :users, controllers: { registrations: 'registrations' }
    # devise_scope :user do
    #   get 'users/sign_out', to: 'devise/sessions#destroy', as: 'logout'
    # end
    # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
    resources :users
    resources :doctor_profiles
    resources :patient_profiles
    # Defines the root path route ("/")
    root 'users#index'
  end
end
