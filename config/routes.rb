Rails.application.routes.draw do
  resources :cats
  resources :cat_rental_requests, only: [:new, :create] do
    member do
      get :approve, :deny
    end
  end
  root to: "cats#index"

  resources :users , only: [:new, :create, :index, :show]
  resource :session, only: [:new, :create, :destroy]
end
