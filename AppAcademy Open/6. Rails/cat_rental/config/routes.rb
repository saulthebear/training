Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :cats, only: %i[index show new update create edit]
  resources :cat_rental_requests, only: %i[new create] do
    member do
      post 'approve'
      post 'deny'
    end
  end
  resources :users, only: %i[new create]
end
