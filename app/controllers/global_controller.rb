class GlobalController < ApplicationController
  def index
    @posts =  Post.left_outer_joins(:likes, :bookmarks).group('posts.id').order('count(bookmarks.id) desc, count(likes.id) desc').limit(20)
    @quick_tweets = QuickTweet.left_outer_joins(:likes, :bookmarks).group('quick_tweets.id').order('count(bookmarks.id) desc, count(likes.id) desc, watches desc').limit(20)
    @all_posts = (@posts + @quick_tweets).shuffle
  end
end