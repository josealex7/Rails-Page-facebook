Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  get 'search_friend', to: 'users#search'
  resources :friendships, only: [:create, :destroy]
  resources :users, only: [:show]
  resources :images, only: [:show, :new, :create]
  put '/users/update_image_portada', to: 'users#update_image_portada'
  put '/users/update_image_profile', to: 'users#update_image_profile'
  get '/profile/fotos/:id', to: 'users#fotos', as: 'profile_fotos'
  get '/profile/friends/:id', to: 'users#friends', as: 'profile_friends'

  get '/publications/:user_id/image/:image_id', to: 'publications#show', as: 'show_publication'

end
