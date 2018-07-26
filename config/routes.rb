Rails.application.routes.draw do
  
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  namespace :api do
    post '/test', to: "crawel#index"
    post 'google_Login', to: "google#googleAuth"
  end
  get '/login', to: "login#index"
  post '/login', to: "login#create"
  get '/logout', to: "login#logout"
  get '/register', to: "register#index"
  post '/register', to: "register#create"
  get '/dash', to: "dash#index"
  post '/activity', to: "dash#crawel"
  get '/activity', to: "activity#index"
  get '/profile', to: "profile#index"
  patch '/profile', to: "profile#updateProfile"
  get '/password', to: "profile#password"
  patch '/password', to: "profile#updatePassword"
  get '/data', to:"data#index"
  get '/g_log/:g_id', to: "login#g_log"
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  require 'sidekiq/web'
  mount Sidekiq::Web, at: '/sidekiq'
end
