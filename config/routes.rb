Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  authenticate :user do
    get '/search', to: 'search#search'

    resources :players
    resources :high_school_teams
    resources :club_teams
    resources :tournaments
    resources :fields
    resources :games, only: [:new, :show, :edit, :update]
  end
end
