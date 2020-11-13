Rails.application.routes.draw do
  get "tos", to: "welcome#tos", as: "tos"
  get "policy", to: "welcome#policy", as: "policy"

  authenticated :user do
    root to: "tenhou_accounts#index"
  end
  root to: "welcome#index", as: "home"

  devise_for :users, skip: %i[sessions registrations]
  devise_scope :user do
    get "signup", to: "devise/registrations#new"
    post "signup", to: "devise/registrations#create"
    get "login", to: "devise/sessions#new"
    # deviseが内部で使用するヘルパーメソッド
    get "login", to: "devise/sessions#new", as: "new_user_session"
    post "login", to: "devise/sessions#create"
    delete "logout", to: "devise/sessions#destroy"
    delete "retirement", to: "devise/registrations#destroy"
    get "my_page", to: "devise/registrations#edit", as: :edit_user_registration
    patch "my_page", to: "devise/registrations#update", as: nil
    put "my_page", to: "devise/registrations#update", as: :update_user_registration
  end

  resources :tenhou_accounts
  resources :teams, only: %i[new edit create update]
  get "teams/join", to: "teams/joins#new", as: "new_team_join"
  post "teams/join", to: "teams/joins#create"
  delete "teams/join", to: "teams/joins#destroy"
  get "teams/invite", to: "teams/invites#new"
  post "teams/invite", to: "teams/invites#create"
  get "teams/:id/logs", to: "teams/logs#index", as: "team_logs"
end
