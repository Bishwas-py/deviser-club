class GlobalController < ApplicationController
  def index
    @posts =  Post.left_outer_joins(:likes, :bookmarks).group('posts.id').order('count(bookmarks.id) desc, count(likes.id) desc').limit(20)
    @quick_tweets = QuickTweet.left_outer_joins(:likes, :bookmarks).group('quick_tweets.id').order('count(bookmarks.id) desc, count(likes.id) desc, watches desc').limit(20)
    @all_posts = (@posts + @quick_tweets).shuffle
  end

  def search
    @posts =  Post.where('title LIKE ?', "%#{params[:search_term]}%").limit(9)
    @quick_tweets = QuickTweet.where('content LIKE ?', "%#{params[:search_term]}%").limit(9)
    @users = User.where('username LIKE ?', "%#{params[:search_term]}%").limit(9)
    @tags = Tag.where('name LIKE ?', "%#{params[:search_term]}%").limit(9)

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update("search-results", partial: "components/search_results")
      end
    end
  end
end