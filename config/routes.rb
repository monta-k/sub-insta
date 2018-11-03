Rails.application.routes.draw do
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'registrations' }

  root to: "pages#index"
  get "pages/terms" => "pages#terms"
  resources :users, only: [:show, :edit, :update]
  resources :posts, only: [:index, :new, :create, :show] do
    resources :photos, only: [:create]
    resources :likes, only: [:create, :destroy], shallow: true
    resources :comments, only: [:index, :create, :destroy], shallow: true
  end
end
