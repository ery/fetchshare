Rails.application.routes.draw do
  root 'archives#index'

  get 'fetch', to: 'archives#index'
  get 'share', to: 'archives#new'

  resources :archives do
    get 'download', on: :member
  end

end
