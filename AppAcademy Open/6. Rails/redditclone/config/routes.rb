Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'subs#index'
  resources :users
  resource :session, only: %i[new create destroy]
  resources :subs
end
