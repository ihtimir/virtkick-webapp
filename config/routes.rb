Rails.application.routes.draw do
  root 'machines#index'

  devise_for :users

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
    end

    resources :disks do
      member do
        post 'resize'
        post 'snapshot'
      end
    end
  end
end
