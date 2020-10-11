Rails.application.routes.draw do
  authenticated :user do
    root to: "users#index"
  end
  root to: 'welcome#index', as: "home"

  devise_for :users, skip: %i[sessions registrations]
  devise_scope :user do
    get 'signup', to: 'devise/registrations#new'
    post 'signup', to: 'devise/registrations#create'
    get 'login', to: 'devise/sessions#new'
    # deviseが内部で使用するヘルパーメソッド
    get 'login', to: 'devise/sessions#new', as: 'new_user_session'
    post 'login', to: 'devise/sessions#create'
    delete 'logout', to: 'devise/sessions#destroy'
    delete 'retirement', to: 'devise/registrations#destroy'
  end

  resources :users, except: %i[new create]
  get 'logs/index'
end
