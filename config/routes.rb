Rails.application.routes.draw do
  get 'shopping/index'
  get 'shopping/show'
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
  post "add" => "home#add", :as => "add"
  root to: "home#index"
  get "categories" => "home#categories", :as => "categories"
  get "category" => "home#category", :as => "category"
end
