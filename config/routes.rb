Rails.application.routes.draw do
  resources :cats
  resources :cat_rental_requests, only: [:new, :create] do
    member do
      get :approve, :deny
    end
  end
end
