Rails.application.routes.draw do
  #Root path
  root "home#index"
  
  #Users Devise
  devise_for :users, controllers: { registrations: "registrations", sessions: "sessions" }
  
  #Path Home
  get '/video_games', to: 'home#show_games', as: 'video_games'
  get 'load_more_publications', to: 'home#load_more', as: 'load_more_publications'

  #Paths users controller
  resources :users, only: [:show]
  get 'search_friend', to: 'users#search'
  get '/profile/fotos/:id', to: 'users#fotos', as: 'profile_fotos'
  get '/profile/friends/:id', to: 'users#friends', as: 'profile_friends'
  get '/profile/pages/:id', to: 'users#pages', as: 'profile_pages'
  get '/users/switch/:id', to: 'users#switch_user', as: 'switch_user'
  put '/users/update_image_portada', to: 'users#update_image_portada'
  put '/users/update_image_profile', to: 'users#update_image_profile'

  #controller userpages
  resources :userpages, only: [:create]

  #Path friendships
  resources :friendships, only: [:create, :destroy]

  #Path Images
  resources :images, only: [:show, :new, :create]
  
  #path publications
  resources :publications, only: [:new, :create, :show] do
    collection do
      get 'load_more_publications', to: 'publications#load_more_publications'
    end
    
    member do
      post '/likes', to: 'likes#create'
      put '/likes', to: 'likes#update'
      post '/comment', to: 'main_comments#create'
      post '/share', to: 'publication_shares#create'
    end
    
    put 'description', to: 'publications#update_description', as: 'publication_description'
  end
  
  get '/chat_friend/:id', to: 'chatfriend#index', as: 'chat_friend'

  resources :messages, only: [:create]

  resources :histories, only:[:create]

  mount ActionCable.server => '/cable'
  
  
end