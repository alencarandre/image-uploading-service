Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :upload, only: [:create]
  resources :images, only: [:index]
end
