json.extract! quick_tweet, :id, :content, :created_at, :updated_at
json.url quick_tweet_url(quick_tweet, format: :json)
