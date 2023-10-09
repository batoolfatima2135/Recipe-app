Rails.application.routes.draw do

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'recipe#index'
  resources :recipe_foods
  resources :foods
  resources :recipes
  # Defines the root path route ("/")
  # root "articles#index"
end
