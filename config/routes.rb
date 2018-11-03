Rails.application.routes.draw do
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'registrations' }

  root to: "pages#index"
  get "pages/terms" => "pages#terms"
  resources :users, only: [:show, :edit, :update]
end
