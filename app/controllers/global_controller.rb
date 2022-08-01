class GlobalController < ApplicationController
  def index
    @posts = Post.last(7)
    @quick_tweets = QuickTweet.all.where('watches').order('watches desc').joins(:likes)
    @all_posts = @posts+@quick_tweets
  end
end