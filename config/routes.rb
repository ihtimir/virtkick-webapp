Rails.application.routes.draw do
  root 'guests#index'

  devise_for :users, skip: [:sessions]

  resources :guests, only: [:index, :create]

  resources :machines do
    member do
      post 'start'
      post 'pause'
      post 'resume'
      post 'stop'
      post 'force_stop'
      post 'restart'
      post 'force_restart'

      post 'mount_iso'

      get 'state'
    end

    resources :disks do
      member do
        post 'resize'
        post 'snapshot'
      end
    end
  end

  get '/machine_progress/:id', to: 'machine_progress#progress', as: 'machine_progress'
end
