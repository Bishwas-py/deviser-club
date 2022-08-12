# frozen_string_literal: true

Rails.application.routes.draw do
  resources :profile do
    collection do
      get :edit
    end
  end
  root 'global#index'
  get '/select' => 'global#select'

  resources :likes, only: %i[create destroy]
  resources :tags
  resources :bookmark, only: %i[create destroy index]
  resources :posts
  resources :quick_tweets, path: :tweet
  resources :comments, only: %i[create destroy update]

  match '@:id' => 'profile#show', :via => [:get], :as => 'profile_show'

  devise_for :users,
             path: 'accounts',
             path_names: {
               sign_in: 'login',
               sign_up: 'register',
               sign_out: 'logout',
               password: 'recover-password',
               confirmation: 'verification'
             }
end
