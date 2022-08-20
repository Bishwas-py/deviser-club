Rails.application.routes.draw do
  get 'notification/index'
  resources :profile do
    collection do
      get :edit
      post :set_appearance
    end
  end

  root "global#index"

  match 'search' => 'global#search', :via => [:post], :as => 'search_content'
  match 'draft' => 'global#drafts', :via => [:get], :as => 'drafts'

  resources :notification
  resources :likes, only: [:create, :destroy]
  resources :tags
  resources :admin
  resources :bookmark, only: [:create, :destroy, :index]
  resources :posts
  resources :quick_tweets, path: :tweet
  resources :comments, only: [:create, :destroy, :update]

  match '@:id' => 'profile#show', :via => [:get], :as => 'profile_show'

  devise_for :users,
             :path => 'accounts',
             :path_names => {
               :sign_in => 'login',
               :sign_up => 'register',
               :sign_out => 'logout',
               :password => 'recover-password',
               :confirmation => 'verification'
             }
end