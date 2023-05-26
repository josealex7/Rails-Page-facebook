Rails.application.routes.draw do
  #Root path
  root "home#index"
  
  #Users Devise
  devise_for :users, controllers: { registrations: "registrations", sessions: "sessions" }
  
  #Path Home
  get '/video_games', to: 'home#videogames', as: 'video_games'

  get '/marketplace', to: 'home#marketplace', as: 'marketplace'
  post '/change_pokemon', to: 'home#change_pokemon', as: 'change_pokemon'

  get 'publications/load_more', to: 'home#load_more', as: 'load_more_publications'

  #Paths users controller
  resources :users, only: [:show]
  get 'search_friend', to: 'users#search'
  get '/profile/fotos/:id', to: 'users#fotos', as: 'profile_fotos'
  get '/profile/friends/:id', to: 'users#friends', as: 'profile_friends'
  get '/profile/pages/:id', to: 'users#pages', as: 'profile_pages'
  get '/profile/shops/:id', to: 'users#shops', as: 'profile_shops'
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
  
  get '/chat_friend/:user_id', to: 'chatfriend#show_conversation', as: 'chat_friend'

  resources :messages, only: [:create]

  resources :histories, only:[:create]

  namespace :api do
    namespace :stripe do
      post '/payments', to: 'payments#create', as: 'create_payments'
      post '/customer', to: 'customers#create', as: 'create_costumer'
    end
    resources :users, only: [:show, :update], defaults: { format: 'json' }
    get '/sign_in', to: 'users#sign_in'
    get '/csrf_token', to: 'application#csrf_token'
  end

  mount ActionCable.server => '/cable'
  
  
end