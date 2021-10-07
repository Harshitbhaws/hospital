Rails.application.routes.draw do
  

    devise_scope :user do
        authenticated :user do
          root 'appointments#index', as: :authenticated_root
        end
      
        unauthenticated do
          root 'devise/sessions#new', as: :unauthenticated_root
        end
      end
    devise_for :users
    resources :doctors
    resources :patients
    resources :appointments
    get 'my_appointments', to: 'appointments#my_appointments'

end
