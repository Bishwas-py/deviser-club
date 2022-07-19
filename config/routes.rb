Rails.application.routes.draw do
  # resources :quick_tweets
  root "quick_tweets#index"
  resources :quick_tweets, path: :tweet
  resources :quick_tweets do
    resources :comments
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html '
  # Defines the root path route ("/")
end