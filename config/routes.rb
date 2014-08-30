Rails.application.routes.draw do
  root 'machines#index'

  resources :machines
end
