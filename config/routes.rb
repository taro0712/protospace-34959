Rails.application.routes.draw do
  devise_for :users
  root to: "prototypes#index"
  resources :users, only: [:new, :create, :show]
  resources :prototypes do
    resources :comments, only: :create
  end
  #resources :prototypes, only: [:new, :create ,:index, :show, :edit, :update, :destroy]
end
