class DraftController < ApplicationController
  before_action :authenticate_user! #-> routes to the login / signup if not authenticated

  def create
    respond_to do |format|
      @draft = current_user.drafts.create(draft_params)
      if @draft.save
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(
            "#{@draft.draftable.model_name.name}-#{@draft.draftable.id}_draft",
            partial: "draft/create",
            locals: { draftable: @draft.draftable }
          )
        }
      else
        format.html { redirect_to @draft.draftable, notice: "Unable to draft." }
      end
    end
  end

  def destroy
    @draft = current_user.drafts.find(params[:id])
    @draft.destroy
    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: turbo_stream.replace(
          "#{@draft.draftable.model_name.name}-#{@draft.draftable.id}_draft",
          partial: "draft/create",
          locals: { draftable: @draft.draftable }
        )
      }
      format.html { redirect_to @draft.draftable, notice: "Unable to draft." }
    end
  end

  private

  def draft_params
    params.require(:draft).permit(:draftable_id, :draftable_type)
  end
end
