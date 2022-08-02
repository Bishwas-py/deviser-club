class GlobalController < ApplicationController
  def index
    @posts = Post.order('created_at desc').last(7)
    @quick_tweets = QuickTweet.all.order('watches desc')
    @all_posts = @posts + @quick_tweets
  end
end