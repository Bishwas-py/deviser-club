Rails.application.routes.draw do

  resources :profile do
    collection do
      get :edit
      post :set_appearance
    end
  end


  match 'search' => 'global#search', :via => [:post], :as => 'search_content'
  match 'draft' => 'global#drafts', :via => [:get], :as => 'drafts'

  post '/', :to => "global#index"
  root "global#index"

  resources :notification do
    collection do
      post :index
      get :read
      post :read
      get :unread
      post :unread
      post :mark_read
    end
  end

  resources :likes, only: [:create, :destroy]
  resources :tags
  resources :admin
  resources :bookmark, only: [:create, :destroy, :index]
  resources :posts do
    collection do
      post :index
    end
  end
  resources :quick_tweets, path: :tweet do
    collection do
      post :index
    end
  end
  resources :comments, only: [:create, :destroy, :update, :show]

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