Rails.application.routes.draw do
  devise_for :users
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
  resources :shopping

  get "search" => "home#search", :as => "search"
  post "searchResults" => "home#search", :as => "searchResults"
  post "add" => "home#add", :as => "add"
  root to: "home#index"
  get "categories" => "home#categories", :as => "categories"
  get "category" => "home#category", :as => "category"

  post "updatecart" => "shopping#update", :as => "updatecart"

  post "checkout" => "shopping#checkout", :as => "checkout"
  get "checkout_" => "shopping#checkout_", :as => "checkout_"
  get "final" => "shopping#final", :as => "final"

  post "remove_from_cart" => "shopping#remove", :as => "remove_from_cart"
end
