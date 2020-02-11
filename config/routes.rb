Rails.application.routes.draw do
  devise_for :users, controllers: { confirmations: 'users/confirmations', passwords: 'users/passwords', registrations: 'users/registrations', sessions: 'users/sessions', unlocks: 'users/unlocks' }
  root 'home#index'

  authenticate :user do
    get '/search', to: 'search#search'

    resources :players do
      resources :player_notes
    end
    resources :high_school_teams
    resources :club_teams
    resources :tournaments
    resources :fields
    resources :games, only: [:new, :show, :edit, :update]
    resources :player_lists
  end
end
