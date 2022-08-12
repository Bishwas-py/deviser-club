# frozen_string_literal: true

require 'test_helper'

class QuickTweetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @quick_tweet = quick_tweets(:one)
  end

  test 'should get index' do
    get quick_tweets_url
    assert_response :success
  end

  test 'should get new' do
    get new_quick_tweet_url
    assert_response :success
  end

  test 'should create quick_tweet' do
    assert_difference('QuickTweet.count') do
      post quick_tweets_url, params: { quick_tweet: { content: @quick_tweet.content } }
    end

    assert_redirected_to quick_tweet_url(QuickTweet.last)
  end

  test 'should show quick_tweet' do
    get quick_tweet_url(@quick_tweet)
    assert_response :success
  end

  test 'should get edit' do
    get edit_quick_tweet_url(@quick_tweet)
    assert_response :success
  end

  test 'should update quick_tweet' do
    patch quick_tweet_url(@quick_tweet), params: { quick_tweet: { content: @quick_tweet.content } }
    assert_redirected_to quick_tweet_url(@quick_tweet)
  end

  test 'should destroy quick_tweet' do
    assert_difference('QuickTweet.count', -1) do
      delete quick_tweet_url(@quick_tweet)
    end

    assert_redirected_to quick_tweets_url
  end
end
