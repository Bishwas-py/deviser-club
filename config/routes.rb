Rails.application.routes.draw do

  resources :profile do
    collection do
      get :edit
    end
  end
  root "global#index"
  get "/select" => "global#select"

  resources :likes, only: [:create, :destroy]
  resources :tags
  resources :bookmark, only: [:create, :destroy, :index]
  resources :posts
  resources :quick_tweets, path: :tweet
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