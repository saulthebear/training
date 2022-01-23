Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: %i[index create destroy show update] do
    resources :artworks, only: :index
    resources :comments, only: :index
  end

  resources :artworks, only: %i[create destroy show update] do
    resources :comments, only: :index
  end

  resources :artwork_shares, only: %i[create destroy]
  resources :comments, only: %i[create destroy]
end
