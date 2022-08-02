class TagsController < ApplicationController
  def index
    @tags = Tag.all
  end

  def show
    @tag = Tag.friendly.find(params[:id])
  end

  private

  def tag_params
    params.require(:tag).permit(:tagable_id, :tagable_type, :name, :description)
  end
end
