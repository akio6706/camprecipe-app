Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root to: 'recipes#index'
  resources :recipes do
    resources :comments, only: :create
    collection do
      get 'level1'
      get 'level2'
      get 'level3'
    end
  end
  resources :users, only: :show
end
