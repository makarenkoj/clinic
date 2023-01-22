Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :users, controllers: { registrations: 'registrations' }

    resources :users
    resources :doctor_profiles
    resources :patient_profiles
    resources :categories, only: %i[index show]
    resources :doctors_appointments

    root 'users#index'
  end
end
