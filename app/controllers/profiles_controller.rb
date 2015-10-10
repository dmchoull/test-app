class ProfilesController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!
  before_action :set_profile, only: [:show, :update, :destroy]

  load_resource only: [:index]
  authorize_resource through: :current_user, singleton: true, except: [:index]

  def index
    authorize! current_user, @profiles
  end

  def show
    render :profile
  end

  def profile
    @profile = current_user.profile || Profile.new(user: current_user)
  end

  def create
    @profile = Profile.new(profile_params)

    if @profile.save
      redirect_to user_root_path, notice: 'Profile was successfully created.'
    else
      render :profile
    end
  end

  def update
    if @profile.update(profile_params)
      redirect_to user_profile_path(@profile.user, @profile), notice: 'Profile was successfully updated.'
    else
      render :profile
    end
  end

  def destroy
    @profile.destroy
    redirect_to user_root_path, notice: 'Profile was successfully destroyed.'
  end

  private

  def set_profile
    @profile = User.find(params[:user_id]).profile
  end

  def profile_params
    params.require(:profile).permit(:name, :bio).merge(params.permit(:user_id))
  end
end
