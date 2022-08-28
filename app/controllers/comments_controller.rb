class CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_comment, only: %i[ show form ]
  authorize_resource

  def show
    @comment.notifications_as_comment.mark_as_read!
  end

  def form
    respond_to do |format|
      format.turbo_stream
    end
  end

  def create
    @comment = current_user.comments.create(comment_params)
    @comment.body = helpers.purify @comment.body
    comment = @comment.save
    respond_to do |format|
      if comment
        format.turbo_stream
      else
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(
            "comment_error_explanation",
            partial: 'components/errors',
            locals: { errors: @comment.errors }
          )
        }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      @comment = current_user.comments.find(params[:id])
      @comment.destroy
      format.turbo_stream {
        render turbo_stream: turbo_stream.remove(
          "#{@comment.hash_id}"
        )
      }
      format.html { redirect_to @comment.commentable, notice: "Comment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def trash
    respond_to do |format|
      @comment = current_user.comments.find(params[:id])
      @comment.trash_it

      format.turbo_stream {
        render turbo_stream: turbo_stream.replace(
          "#{@comment.hash_id}",
          partial: 'comments/deleted',
          locals: { hash_id: @comment.hash_id }
        )
      }
      format.html { redirect_to @comment.commentable, notice: "Comment was successfully destroyed." }
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
  def set_comment
    # Load post is required for authorization of posts with cancancan
    @comment = Comment.friendly.find(params[:id])
  end
  def comment_params
    params.require(:comment).permit(:body, :commentable_id, :commentable_type, :parent_id)
  end


end
