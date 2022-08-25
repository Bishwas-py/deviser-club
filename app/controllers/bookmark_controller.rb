class BookmarkController < ApplicationController
  before_action :authenticate_user! #-> routes to the login / signup if not authenticated

  def index
    @bookmarks = current_user.bookmarks
  end

  def create
    respond_to do |format|
      @bookmark = current_user.bookmarks.create(bookmark_params)
      if @bookmark.save
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(
            "#{@bookmark.bookmarkable.model_name.name}-#{@bookmark.bookmarkable.id}_bookmarks",
            partial: "bookmark/create",
            locals: { bookmarkable: @bookmark.bookmarkable }
          )
        }
      else
        format.html { redirect_to @bookmark.bookmarkable, notice: "Unable to bookmark." }
      end
    end
  end

  def destroy
    @bookmark = current_user.bookmarks.find(params[:id])
    @bookmark.destroy
    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: turbo_stream.replace("#{@bookmark.bookmarkable.model_name.name}-#{@bookmark.bookmarkable.id}_bookmarks", partial: "bookmark/create", locals: { bookmarkable: @bookmark.bookmarkable })
      }
      format.html { redirect_to @bookmark.bookmarkable, notice: "Unable to bookmark." }
    end
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:bookmarkable_id, :bookmarkable_type)
  end
end
