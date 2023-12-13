Rails.application.routes.draw do
  get 'ratings/new'
  get 'ratings/create'
  devise_for :users
  devise_for :guests

  root to: 'home#index'
  get 'search', to: 'search#results', as: 'search_results'
  get '/home/all/:city', to: 'home#all', as: 'all_home'
  get 'my_reservations', to: 'reservations#my_reservations'
  
  resources :inns, only: [:show, :new, :create, :edit, :update] do        
    get 'my_stays', to: 'reservations#my_stays'
    get 'my_active_stays', to: 'reservations#my_active_stays'  
  
    resources :rooms, only: [:new, :create, :show, :edit, :update] do 
      resources :prices, only: [:new, :create, :show, :destroy]
      resources :reservations, only: [:show, :new, :create, :destroy] do
        resources :ratings, only: [:index, :new, :create]       
        get 'confirmation', to: 'reservations#confirmation'
        get 'ready', to: 'reservations#ready'
        get 'checkin', to: 'reservations#checkin'
        get 'checkout', to: 'reservations#checkout'        
      end
    end
  end
 
  resources :cities, only: [] do
    get 'pousadas', to: 'cities#pousadas'
  end

  resources :reviews do
    resource :response, only: [:new, :create]
  end

  namespace :api do
    get :list_all_inns_available, to: 'inns#list_available_inns'
    get :room_details, to: 'inns#room_details'
    get :verify_reservation, to: 'reservations#verify_reservation'
  end
end
