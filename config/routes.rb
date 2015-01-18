Rails.application.routes.draw do
  devise_for :users

  root 'circles#index'
  resources :circles do
    resources :comments, only: [:create]
    resources :pictures, only: [:create, :destroy]
    resources :memberships, only: [:create]
  end

end
