Rails.application.routes.draw do
  root "global#index"
  resources :likes, only: [:create, :destroy]
  resources :bookmark, only: [:create, :destroy, :index]
  resources :posts
  resources :quick_tweets, path: :tweet
  resources :quick_tweets
  resources :comments, only: [:create, :destroy, :update]


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