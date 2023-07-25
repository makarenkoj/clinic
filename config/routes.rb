Rails.application.routes.draw do
  match '/500', via: :all, to: 'errors#internal_server_error'
  match '/422', via: :all, to: 'errors#unprocessable_content'
  match '/404', via: :all, to: 'errors#not_found'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :users, controllers: { registrations: 'registrations' }

    resources :users
    resources :doctor_profiles
    resources :patient_profiles
    resources :categories
    resources :doctors_appointments

    resources :pixels, only: %i[create update index] do
      collection do
        put :delete_all
        put :delete_last
      end
    end
 
    resources :search, only: [:index] do
      collection do
        post :search
        post :search_categories

      end
    end

    root 'users#index'

    get 'set_theme', to: 'theme#update'
    get 'pages/space'
  end
end
