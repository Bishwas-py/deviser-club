Rails.application.routes.draw do
  match '@:id' => 'profile#show', :via => [:get], :as => 'profile_show'
  match '@:id/tweets' => 'profile#quick_tweets', :via => [:get], :as => 'user_quick_tweets'
  match '@:id/posts' => 'profile#posts', :via => [:get], :as => 'user_posts'
  match '@:id/comments' => 'profile#comments', :via => [:get], :as => 'user_comments'
  match 'comments/form/:id' => 'comments#form', :via => [:post], :as => 'comments_form'
  match 'comment/trash/:id' => 'comments#trash', :via => [:post], :as => 'comments_trash'

  match 'search' => 'global#search', :via => [:post], :as => 'search_content'
  match 'draft' => 'global#drafts', :via => [:get], :as => 'drafts'

  post '/', :to => "global#index"
  root "global#index"

  resources :profile do
    collection do
      get :edit
      post :set_appearance
    end
  end

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
  resources :draft, only: [:create, :destroy]

  resources :posts do
    collection do
      post :pagy_index, :path => :p
    end
  end

  resources :quick_tweets, path: :tweet do
    collection do
      post :pagy_index, :path => :p
    end
  end
  resources :comments, only: [:create, :destroy, :update, :show]

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