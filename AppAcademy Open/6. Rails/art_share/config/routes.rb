Rails.application.routes.draw do
  resources :artworks, only: %i[index create destroy show update]
  resources :users, only: %i[index create destroy show update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
