Rails.application.routes.draw do
  root to: "employees#index"

  resources :employees, except: %i[show destroy]
  delete "employees/:id", to: "employees#destroy", as: :destroy_employee

  resources :employees, only: [] do
    member do
      patch :set_table
    end
  end
end
