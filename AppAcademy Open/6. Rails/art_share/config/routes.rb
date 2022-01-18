Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: %i[index create destroy show update]
  resources :artworks, only: %i[index create destroy show update]
  resources :artwork_shares, only: %i[create destroy]
end
