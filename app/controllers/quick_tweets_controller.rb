class QuickTweetsController < ApplicationController
  before_action :set_quick_tweet, only: %i[ show edit update destroy ]

  before_action :check_user!, only: %i[ edit update destroy ]

  # GET /quick_tweets or /quick_tweets.json
  def index
    @quick_tweets = QuickTweet.all.order(created_at: :desc)
    @quick_tweet = QuickTweet.new
  end

  # GET /quick_tweets/1 or /quick_tweets/1.json
  def show
    @quick_tweet.update(watches: @quick_tweet.watches + 1)
    @comments = @quick_tweet.comments.order(created_at: :desc)
  end

  # GET /quick_tweets/new
  def new
    @quick_tweet = QuickTweet.new
  end

  # GET /quick_tweets/1/edit
  def edit
  end

  # POST /quick_tweets or /quick_tweets.json
  def create
    @quick_tweet = QuickTweet.new(quick_tweet_params)
    @quick_tweet.ip_field = request.remote_ip
    @quick_tweet.user = current_user

    # should remove invalid chars
    @quick_tweet.content = @quick_tweet.content.gsub("\u200D", "").gsub(/\P{Print}|\p{Cf}/, "")

    image_file_io, image_name = helpers.create_og_image(helpers.sanitize(@quick_tweet.content, tags: %w()))
    @quick_tweet.image.attach(io: image_file_io, filename: image_name, content_type: 'image/png')

    respond_to do |format|
      if @quick_tweet.save
        format.turbo_stream
        format.html { redirect_to quick_tweet_url(@quick_tweet) }
        format.json { render :show, status: :created, location: @quick_tweet }
      else
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace("#{helpers.dom_id(@quick_tweet)}_form", partial: 'form', locals: { quick_tweet: @quick_tweet })
        }
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @quick_tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quick_tweets/1 or /quick_tweets/1.json
  def update
    @quick_tweet.content = @quick_tweet.content.gsub("\u200D", "").gsub(/\P{Print}|\p{Cf}/, "")
    respond_to do |format|
      if @quick_tweet.update(quick_tweet_params)
        @quick_tweet.broadcast_update partial: "quick_tweets/tweet_cert", target: "#{helpers.dom_id(@quick_tweet)}_target"
        @quick_tweet.broadcast_update partial: "quick_tweets/quick_tweet"
        # while updating, the target will be replaced/updated by the partial
        format.html { redirect_to quick_tweet_url(@quick_tweet) }
        format.json { render :show, status: :ok, location: @quick_tweet }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @quick_tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quick_tweets/1 or /quick_tweets/1.json
  def destroy
    @quick_tweet.destroy
    respond_to do |format|
      @quick_tweet.broadcast_remove_to :quick_tweets, target: "#{helpers.dom_id(@quick_tweet)}"
      @quick_tweet.broadcast_update partial: "components/notice", target: "#{helpers.dom_id @quick_tweet}_alert_notice", locals: { alert: "This post is deleted completely deleted, try reaching <a class='link' href='/'>Home</a>." }
      @quick_tweet.broadcast_remove_to [@quick_tweet], target: "#{helpers.dom_id(@quick_tweet)}_target"
      @quick_tweet.broadcast_remove_to [@quick_tweet], target: "#{helpers.dom_id(@quick_tweet)}_comments"

      format.html { redirect_to quick_tweets_url }
      format.json { head :no_content }
    end
  end

  private

  # user logged in permission

  def check_user!
    if request.remote_ip != @quick_tweet.ip_field
      puts "authenticate_user! 101", authenticate_user!
      authenticate_user! or redirect_to quick_tweet_url, notice: "You are not authorized to edit this quick tweet."
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_quick_tweet
    @quick_tweet = QuickTweet.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def quick_tweet_params
    params.require(:quick_tweet).permit(:content)
  end
end
