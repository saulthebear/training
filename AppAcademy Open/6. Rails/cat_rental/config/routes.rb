Rails.application.routes.draw do
  resources :cats, only: %i[index show new update create edit]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
