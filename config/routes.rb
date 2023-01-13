Rails.application.routes.draw do
  resources :doctors, only: [:show, :update]

  resources :patients, only: [:index]
end
