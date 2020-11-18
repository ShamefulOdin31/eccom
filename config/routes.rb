Rails.application.routes.draw do
  get 'home/index'
  get 'home/show'
  get 'home/new'
  get 'home/create'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :home

  get "search" => "home#search", :as => "search"
  post "searchResults" => "home#search", :as => "searchResults"

  root to: "home#index"
end
