Rails.application.routes.draw do
  devise_for :users
  devise_for :guests

  root to: 'home#index'
  get 'search', to: 'search#results', as: 'search_results'
  get '/home/all/:city', to: 'home#all', as: 'all_home'

  resources :inns, only: [:show, :new, :create, :edit, :update] do
    resources :rooms, only: [:new, :create, :show, :edit, :update] do
      resources :prices, only: [:new, :create, :show, :destroy]
      resources :reservations, only: [:show, :new, :create, :destroy] do
        get 'pre_save', on: :member
        get 'confirmation', on: :member
        get 'pre_confirmation', on: :member
        get 'ready', on: :member 
        member do
          post 'checkin'
          get 'my_active_stays', to: 'reservations#my_active_stays'
          post 'finish_stay'
        end      
      end
    end
  end

  resources :cities, only: [] do
    get 'pousadas', to: 'cities#pousadas'
  end
end
