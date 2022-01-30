Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'bands#index'
  resources :users, only: %i[new create]
  resource :session, only: %i[new create destroy]
  resources :bands do
    resources :albums, only: %i[new]
  end
  resources :albums, except: %i[new index]
end
