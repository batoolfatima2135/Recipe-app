Rails.application.routes.draw do

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'recipes#public'
  resources :recipe_foods
  resources :foods
  resources :recipes do
    put 'toggle_public', on: :member
    resources :recipe_foods
  end
  get 'general_shoping_list', to: 'general_shoping#index'

end
