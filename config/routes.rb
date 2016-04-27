Rails.application.routes.draw do
  root "games#new"
  resources :games, only: [:create, :show, :destroy] do
    resource :game_sessions, only: [:create], as: :sessions
  end
  resources :players, only: [:create]
  resource :guess, only: [:create]
end
