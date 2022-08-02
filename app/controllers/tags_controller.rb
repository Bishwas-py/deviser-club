class TagsController < ApplicationController
  def index
    @tags = Tag.all
  end

  def show
    tag_name = params[:id].capitalize
    @tag = Tag.find_by(name: tag_name)
  end

  private

  def tag_params
    params.require(:tag).permit(:tagable_id, :tagable_type, :name, :description)
  end
end
