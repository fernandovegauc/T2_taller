Rails.application.routes.draw do
  get 'albums/create'
  get 'albums/index'
  get 'albums/show'
  get 'albums/play'
  get 'albums/destroy'
  get 'tracks/create'
  get 'tracks/index'
  get 'tracks/show'
  get 'tracks/play'
  get 'tracks/destroy'
  get 'artists/create'
  get 'artists/index'
  get 'artists/show'
  get 'artists/play'
  get 'artists/destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :artists, only: [:create, :index, :show, :destroy] do
    resources :albums, only: [:create, :index]
    resources :tracks, only: [:index]
  end
  resources :albums, only: [:index, :show, :destroy] do
    resources :tracks, only: [:create, :index]
  end
  resources :tracks, only: [:index, :show, :destroy] 
  put 'artists/:id/albums/play', to: 'artists#play'
  put 'albums/:id/albums/tracks/play', to: 'albums#play'
  put 'tracks/:id/play', to: 'tracks#play'
end
