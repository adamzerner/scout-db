Rails.application.routes.draw do
  root 'home#index'

  resources :players
  resources :high_school_teams
end
