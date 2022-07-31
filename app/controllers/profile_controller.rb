class ProfileController < ApplicationController
  before_action :set_profile, only: %i[ index update edit ]

  def show
    @profile = User.find_by(username: params[:id]).profile
  end

  def index
  end

  def edit
  end

  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to profile_url(@profile), notice: "Profile was successfully updated." }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_profile
    @profile = Profile.find_or_create_by(user_id: current_user.id)
  end

  # Only allow a list of trusted parameters through.
  def profile_params
    params.require(:profile).permit(:name, :bio, :description, :avatar)
  end

end
