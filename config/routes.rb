Rails.application.routes.draw do
  

  get 'invoices/index'
  get 'invoices/show'
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
    devise_for :users, :controllers => {:registrations => "registrations"}
    resources :doctors
    resources :patients
    resources :appointments do
      get 'confirmation', on: :member
      get 'reject', on: :member
      get 'export_appointments', on: :member
    end
    get 'my_appointments', to: 'appointments#my_appointments'
    get 'todays_appointments', to: 'appointments#todays_appointments'
    get 'approved_appointments', to: 'appointments#approved_appointments'
    get 'rejected_appointments', to: 'appointments#rejected_appointments'
    get 'all_appointments', to: 'appointments#all_appointments'
    get 'states', to: 'appointments#states'
end
