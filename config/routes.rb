Rails.application.routes.draw do
  # devise_for :users, skip: %i[sessions password]
  devise_scope :user do
    get 'signup', to: 'devise/registrations#new'
    post 'signup', to: 'devise/registrations#create'
    get 'login', to: 'devise/sessions#new'
    post 'login', to: 'devise/sessions#create'
    delete 'logout', to: 'devise/sessions#destroy'
    get 'password', to: 'devise/passwords#edit'
    patch 'password', to: 'devise/passwords#update'
    delete 'retirement', to: 'devise/registrations#destroy'
  end
  resources :users

  root to: 'welcome#index'
  get 'logs/index'
end
