Rails.application.routes.draw do
  root to: 'subs#index'
  resources :users
  resource :session, only: %i[new create destroy]
  resources :subs
  resources :posts, except: %i[index]
end
