# frozen_string_literal: true

require 'application_system_test_case'

class QuickTweetsTest < ApplicationSystemTestCase
  setup do
    @quick_tweet = quick_tweets(:one)
  end

  test 'visiting the index' do
    visit quick_tweets_url
    assert_selector 'h1', text: 'Quick tweets'
  end

  test 'should create quick tweet' do
    visit quick_tweets_url
    click_on 'New quick tweet'

    fill_in 'Content', with: @quick_tweet.content
    click_on 'Create Quick tweet'

    assert_text 'Quick tweet was successfully created'
    click_on 'Back'
  end

  test 'should update Quick tweet' do
    visit quick_tweet_url(@quick_tweet)
    click_on 'Edit this quick tweet', match: :first

    fill_in 'Content', with: @quick_tweet.content
    click_on 'Update Quick tweet'

    assert_text 'Quick tweet was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Quick tweet' do
    visit quick_tweet_url(@quick_tweet)
    click_on 'Destroy this quick tweet', match: :first

    assert_text 'Quick tweet was successfully destroyed'
  end
end
