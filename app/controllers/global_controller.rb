class GlobalController < ApplicationController
  def index
    @posts = Post.last(7)
    @quick_tweets = QuickTweet.last(7)
    @all_posts = @posts+@quick_tweets
  end
end
