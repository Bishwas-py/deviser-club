# frozen_string_literal: true

json.array! @quick_tweets, partial: 'quick_tweets/quick_tweet', as: :quick_tweet
