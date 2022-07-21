class CommentsController < ApplicationController
  before_action :set_quick_tweet, only: [:create, :destroy, :update]
  before_action :set_comment, only: [:destroy, :update]

  def create
    @comment = @quick_tweet.comments.create(comment_params)
    @comment.ip_field = request.remote_ip
    @comment.content = @comment.content.gsub("\u200D", "").gsub(/\P{Print}|\p{Cf}/, "")

    respond_to do |format|
      if @comment.save
        format.turbo_stream
        format.html { redirect_to quick_tweet_url(@quick_tweet), notice: "Commented successfully." }
        format.json { render :show, status: :created, location: @quick_tweet }
      else
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace("#{helpers.dom_id(@comment)}_form", partial: 'form', locals: { quick_tweet: @quick_tweet, comment: @comment })
        }
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @quick_tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if request.remote_ip != @comment.ip_field
        format.html { redirect_to quick_tweet_path(@quick_tweet), alert: "You can't delete other people's comments." }
      else
        @comment.destroy
        @comment.broadcast_remove_to [@quick_tweet, :comments], target: "#{helpers.dom_id_for_records(@quick_tweet, @comment)}"
        format.turbo_stream {
          render turbo_stream: turbo_stream.remove("#{helpers.dom_id_for_records(@quick_tweet, @comment)}")
        }
        format.html { redirect_to quick_tweet_path, notice: "Todo was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  end

  def update
    respond_to do |format|
      unless @comment.update(comment_params)
        format.html { redirect_to quick_tweet_path(@quick_tweet), alert: "Comment was not updated." }
      end
    end
  end

  private

  def set_quick_tweet
    @quick_tweet = QuickTweet.find(params[:quick_tweet_id])
  end

  def set_comment
    @comment = @quick_tweet.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

end
