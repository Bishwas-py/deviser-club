class QuickTweetsController < ApplicationController
  before_action :set_quick_tweet, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: %i[ new edit update create destroy ]
  authorize_resource

  def index
    @pagy, @quick_tweets = pagy(QuickTweet.published, items: 5)
  end

  def pagy_index
    @pagy, @quick_tweets = pagy(QuickTweet.published, items: 7)

    respond_to do |format|
      format.turbo_stream
    end
  end

  def show
    @quick_tweet.update(watches: @quick_tweet.watches + 1)
    @comments = @quick_tweet.comments.order(created_at: :desc)
  end

  def new
    @quick_tweet = QuickTweet.new
  end

  def edit
  end

  def create
    @quick_tweet = QuickTweet.new(quick_tweet_params)
    @quick_tweet.ip_field = request.remote_ip
    @quick_tweet.user = current_user

    respond_to do |format|
      if @quick_tweet.save
        format.html { redirect_to quick_tweet_url(@quick_tweet) }
        format.json { render :show, status: :created, location: @quick_tweet }
      else
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace("error_explanation", partial: 'components/errors', locals: { errors: @quick_tweet.errors })
        }
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @quick_tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @quick_tweet.update(quick_tweet_params)
        # while updating, the target will be replaced/updated by the partial
        format.html { redirect_to quick_tweet_url(@quick_tweet) }
        format.json { render :show, status: :ok, location: @quick_tweet }
      else
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace("error_explanation", partial: 'components/errors', locals: { errors: @quick_tweet.errors })
        }
        format.html { render :edit, status: :unprocessable_entity, alert: "Quick Tweet was not updated." }
        format.json { render json: @quick_tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @quick_tweet.destroy
    respond_to do |format|
      format.html { redirect_to root_path, alert: "Quick Tweet was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  def set_quick_tweet
    @quick_tweet = QuickTweet.find(params[:id])
  end

  def quick_tweet_params
    params.require(:quick_tweet).permit(:body, :commit)
  end
end
