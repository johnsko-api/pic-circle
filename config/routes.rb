Rails.application.routes.draw do
  devise_for :users

  root 'circles#index'
  resources :circles do
    resources :comments, only: [:create]
  end

  resources :circles do
    resources :pictures, only: [:create, :destroy]
  end

end
