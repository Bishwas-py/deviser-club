class LikesController < ApplicationController
  def create
    respond_to do |format|
      @like = current_user.likes.create(like_params)
      if @like.save
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace("#{@like.likeable.model_name.name}-#{@like.likeable.id}", partial: "likes/create", locals: { likeable: @like.likeable })
        }
      else
        format.html { redirect_to @like.likeable, notice: "Unable to like." }
      end
    end
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    @like.destroy
    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: turbo_stream.replace("#{@like.likeable.model_name.name}-#{@like.likeable.id}", partial: "likes/create", locals: { likeable: @like.likeable })
      }
      format.html { redirect_to @like.likeable, notice: "Unable to like." }
    end
  end

  private

  def like_params
    params.require(:like).permit(:likeable_id, :likeable_type)
  end

end
