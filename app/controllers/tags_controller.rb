class TagsController < ApplicationController
  def index

  end

  private

  def tag_params
    params.require(:tag).permit(:tagable_id, :tagable_type, :name, :description)
  end
end
