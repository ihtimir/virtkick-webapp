Rails.application.routes.draw do
  root 'machines#index'

  resources :machines do
    member do
      get 'start' # TODO: needs to be POST for security reasons
      get 'pause'
      get 'resume'
      get 'stop'
      get 'force_stop'
      get 'restart'
      get 'force_restart'
    end

    resources :disks do
      member do
        post 'resize'
        post 'snapshot'
      end
    end
  end
end
