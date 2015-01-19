Rails.application.routes.draw do
  devise_for :users

  root 'circles#index'
  resources :circles do
    resources :comments, only: [:create]
    resources :pictures, only: [:create, :destroy]
    resources :memberships, only: [:create]

  end

get "/circles/:id/pending" => "circles#pending", :as => :pending
patch "/circles/:id/pending" => "circles#approval", :as => :approval


end
