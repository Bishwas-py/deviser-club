class ProfileController < ApplicationController
  before_action :authenticate_user!, only: %i[ index edit update ]
  before_action :set_profile, only: %i[ index update edit ]

  def show
    @profile = User.friendly.find(params[:id]).profile
  end

  def quick_tweets
    @profile = User.friendly.find(params[:id]).profile
    render(:template => "profile/quick_tweets")
  end

  def posts
    @profile = User.friendly.find(params[:id]).profile
    render(:template => "profile/posts")
  end

  def comments
    @profile = User.friendly.find(params[:id]).profile
    render(:template => "profile/comments")
  end

  def index
  end

  def set_appearance
    profile = current_user.profile
    if profile.appearance == "light" or profile.appearance.nil?
      profile.appearance = :dark
    else
      profile.appearance = :light
    end
    profile.update(appearance: profile.appearance)

    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: turbo_stream.replace(
          "appearance_toggle", partial: 'components/aside_bar/appearance_toggle',
          locals: { current_user: current_user })
      }
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to edit_profile_index_path, notice: "Profile was successfully updated." }
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
