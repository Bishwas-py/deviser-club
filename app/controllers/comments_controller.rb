# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    @comment = current_user.comments.create(comment_params)
    @comment.body = helpers.purify @comment.body
    comment = @comment.save
    respond_to do |format|
      if comment
        format.turbo_stream
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('comment_error_explanation', partial: 'components/errors',
                                                                                 locals: { errors: @comment.errors })
        end
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      @comment = current_user.comments.find(params[:id])
      @comment.destroy
      @comment.broadcast_remove_to [@comment.commentable, :comments], target: helpers.dom_id(@comment).to_s
      format.html { redirect_to @comment.commentable, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def update
    respond_to do |format|
      unless @comment.update(comment_params)
        format.html { redirect_to commentable_path(@commentable), alert: 'Comment was not updated.' }
      end
    end
  end

  private

  def comment_params
    puts "n_params: #{params}"
    params.require(:comment).permit(:body, :commentable_id, :commentable_type)
  end
end
