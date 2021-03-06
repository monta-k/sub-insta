Rails.application.routes.draw do
  
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'registrations' }

  root to: "pages#index"
  get "pages/terms", to: "pages#terms"
  get "/search", to: "pages#search"
  get 'notifications/:id/link_through', to: 'notifications#link_through', as: :link_through
  resources :users, only: [:index, :show, :edit, :update] do
    member do
      get :following, :followers
    end
  end
  resources :posts, only: [:index, :new, :create, :show, :destroy] do
    resources :photos, only: [:create]
    resources :likes, only: [:create, :destroy], shallow: true
    resources :comments, only: [:index, :create, :destroy], shallow: true
  end
  resources :relationships, only: [:create, :destroy]
end
