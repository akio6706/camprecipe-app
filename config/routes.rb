Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root to: 'recipes#index'
  resources :recipes do
    resources :comments, only: :create
  end
  resources :users, only: [:show, :edit, :update]
end
