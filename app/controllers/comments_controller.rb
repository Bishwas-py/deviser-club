class CommentsController < ApplicationController
  before_action :set_commentable, only: [:create, :destroy, :update]

  def create
    @comment = current_user.comment.create(like_params)
    @comment.body = helpers.purify @comment.body

    respond_to do |format|
      if @comment.save
        # @comment.broadcast_prepend_to [@commentable, :comments],
        #                               partial: "comments/comment",
        #                               target: "#{helpers.dom_id(@commentable)}_comments",
        #                               locals: {
        #                                 commentable: @commentable
        #                               }
        format.turbo_stream
        format.html { redirect_to @comment.commentable, notice: "Commented successfully." }
        # format.json { render :show, status: :created, location: @commentable }
      else
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace("#{helpers.dom_id(@comment)}_form", partial: 'form', locals: { commentable: @commentable, comment: @comment })
        }
        format.html { render :new, status: :unprocessable_entity }
        # format.json { render json: @commentable.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      @comment.destroy
      @comment.broadcast_remove_to [@commentable, :comments], target: "#{helpers.dom_id_for_records(@commentable, @comment)}"
      format.html { redirect_to commentable_path, notice: "Todo was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def update
    respond_to do |format|
      unless @comment.update(comment_params)
        format.html { redirect_to commentable_path(@commentable), alert: "Comment was not updated." }
      end
    end
  end

  private

  def set_commentable
    @commentable = QuickTweet.find(params[:commentable_id])
  end

  def comment_params
    params.require(:comment).permit(:body, :commentable_id, :commentable_type)
  end

end
