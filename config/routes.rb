Rails.application.routes.draw do
  resources :posts
  devise_for :users,
             :path => 'accounts',
             :path_names => {
               :sign_in => 'login',
               :sign_up => 'register',
               :sign_out => 'logout',
               :password => 'recover-password',
               :confirmation => 'verification'
             }

  # resources :quick_tweets
  root "quick_tweets#index"
  get 'global', to: 'global#index'
  resources :quick_tweets, path: :tweet
  resources :quick_tweets do
    resources :comments
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html '
  # Defines the root path route ("/")
end