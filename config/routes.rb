Rails.application.routes.draw do
  devise_for :users,
    controllers: { sessions: 'sessions',
                   omniauth_callbacks: 'users/omniauth_callbacks' }

  root 'states#index'
  get 'faq', to: 'pages#faq'
  get 'search', controller: :main
  get 'login', to: 'pages#login'
  get 'municipalities', to: 'states#index'

  resources :states
  resources :districts
  resources :precincts
  resources :municipalities
end
