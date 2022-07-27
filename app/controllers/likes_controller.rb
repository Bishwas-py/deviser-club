class LikesController < ApplicationController
  before_action :set_post, only: %i[ create ]

  def create
    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: turbo_stream.replace("like-#{@post.id}", partial: "likes/create", locals: { post: @post, like: current_user.likes.find_by(post: @post) })
      }
      if current_user.likes.create(like_params)
        format.html { redirect_to post_url(@post), notice: "Liked successfully." }
      else
        format.html { redirect_to post_url(@post), notice: "Unable to like." }
      end
    end
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    @like.destroy
    redirect_to post_url(@like.post)
  end

  private

  def like_params
    params.require(:like).permit(:post_id)
  end

  def set_post
    @post = Post.find(params[:like][:post_id])
  end
end
