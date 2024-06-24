Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root 'books#home'

  resources :books do
    resources :comments, only: [:create, :update, :destroy]
    resources :ratings, only: [:create, :update, :destroy]
  end

  resources :wishlists
  resources :libraries
  resources :readings

  get 'search_results', to: 'books#search_results'
  get 'books/add', to: 'books#add', as: 'add_book'

end
