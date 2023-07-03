Rails.application.routes.draw do

  namespace :api do
    resources :users, only: [:index, :create, :destroy]
    post "users/login", to: "users#login"
    get "user", to: "users#current"
    put "users", to: "users#update"
  end
  
  namespace :api do
    resources :articles, only: [:index, :create]
    get "articles/:slug", to: "articles#show"
    put "articles/:slug", to: "articles#update"
    delete "articles/:slug", to: "articles#destroy"
  end

end
