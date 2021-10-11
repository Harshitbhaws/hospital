Rails.application.routes.draw do
  

  devise_for :admins
    devise_scope :user do
      
        authenticated :user, ->(u) { u.role=="doctor" } do
          root to: "appointments#todays_appointments", as: :doctor_root
        end
        authenticated :user, ->(u) { u.role=="patient" } do
          root to: "appointments#my_appointments", as: :patient_root
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
    get 'todays_appointments', to: 'appointments#todays_appointments'
end
