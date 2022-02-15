Rails.application.routes.draw do
  root to: 'subs#index'
  resources :users
  resource :session, only: %i[new create destroy]
  resources :subs do
    resources :posts, only: %i[new]
  end
  resources :posts, except: %i[new index]
end
