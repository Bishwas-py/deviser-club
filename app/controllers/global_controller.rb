class GlobalController < ApplicationController
  before_action :authenticate_user!, only: [:drafts]

  def index
    @q_pagy, @quick_tweets = pagy(QuickTweet.published.
      left_outer_joins(:likes, :bookmarks).group('quick_tweets.id').
      order('count(bookmarks.id) desc, count(likes.id) desc, watches desc'), items: 12)
    @p_pagy, @posts = pagy(Post.published.
      left_outer_joins(:likes, :bookmarks).group('posts.id').
      order('count(bookmarks.id) desc, count(likes.id) desc'), items: 12)

    respond_to do |format|
      format.html           # responds to GET requests to /posts
      format.turbo_stream   # responds to POST requests to /posts
    end
  end
  def drafts
    @posts = Post.where(draft: true, user: current_user)
    @quick_tweets = QuickTweet.where(draft: true, user: current_user)
    @all_posts = @posts + @quick_tweets
    render(:template => "global/index")
  end

  def search
    @quick_tweets = QuickTweet.published.
      where(self.ssq "body").limit(9)
    @posts = Post.published.
      where("#{self.sq "title"} OR #{self.ssq "body"}").limit(9)
    @users = User.joins(:profile).
      where(
        "#{self.sq "username"} OR #{self.sq "name"} OR #{self.csq "bio"}"
      ).limit(9)
    @tags = Tag.where("#{self.sq "name"}").limit(9)

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update("search-results", partial: "components/search/search_results")
      end
    end
  end

  protected
  def csp(param)
    # Clear search parameter,
    # basically removes all the html and return clean text.
    "regexp_replace(#{param}, E'<[^>]+>', '', 'gi')"
  end

  def csq(param)
    # returns sql query for search results with cs param
    "#{self.csp param} ILIKE '%#{params[:search_term]}%'"
  end

  def sq(param)
    # returns sql query for search results without cs param
    "#{param} ILIKE '%#{params[:search_term]}%'"
  end

  def ssq(param)
    # returns smart sql query for search results with cs param
    search_param = params[:search_term].sub(' ', '%')
    "#{self.csp param} ILIKE '%#{search_param}%'"
  end
end