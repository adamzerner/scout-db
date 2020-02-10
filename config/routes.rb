Rails.application.routes.draw do
  devise_for :users, controllers: { confirmations: 'users/connfirmations', passwords: 'users/passwords', registrations: 'users/registrations', sessions: 'users/sessions', unlocks: 'users/unlocks' }
  root 'home#index'

  authenticate :user do
    get '/search', to: 'search#search'

    resources :players
    post '/players/:player_id/create_or_update_player_note', to: 'players#create_or_update_player_note'
    resources :high_school_teams
    resources :club_teams
    resources :tournaments
    resources :fields
    resources :games, only: [:new, :show, :edit, :update]
    resources :player_lists
  end
end
