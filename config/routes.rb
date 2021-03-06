Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }
  resources :tasks, except: %i[show edit update destroy]
  resources :groups, except: %i[update destroy]
  get '/about', to: 'static_pages#about'
  get '/home', to: 'static_pages#home'

  root to: "static_pages#landing"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
