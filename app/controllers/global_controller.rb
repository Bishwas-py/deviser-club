# frozen_string_literal: true

class GlobalController < ApplicationController
  def index
    @posts = Post.left_outer_joins(:likes, :bookmarks)
                 .group('posts.id')
                 .order('count(bookmarks.id) desc, count(likes.id) desc')
                 .limit(20)
    @quick_tweets = QuickTweet.left_outer_joins(:likes, :bookmarks)
                              .group('quick_tweets.id')
                              .order('count(bookmarks.id) desc, count(likes.id) desc, watches desc')
                              .limit(20)
    @all_posts = (@posts + @quick_tweets).shuffle
  end

  def search
    @posts =  Post.where(
      "title ILIKE '%#{params[:search_term]}%' OR
      body ILIKE '%#{params[:search_term]}%'").limit(9)
    @quick_tweets = QuickTweet.where('content ILIKE ?', "%#{params[:search_term]}%").limit(9)
    @users = User.where('username ILIKE ?', "%#{params[:search_term]}%").limit(9)
    @tags = Tag.where('name ILIKE ?', "%#{params[:search_term]}%").limit(9)

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update("search-results", partial: "components/search/search_results")
      end
    end
  end
end
