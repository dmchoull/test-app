class ProfilesController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!
  before_action :set_profile, only: [:show, :edit, :update, :destroy]

  def index
    @profiles = Profile.all
  end

  def profile
    if current_user.profile
      @profile = current_user.profile
    else
      @profile = Profile.new
      render :new
    end
  end

  def show
  end

  def new
    @profile = Profile.new
  end

  def edit
  end

  def create
    @profile = Profile.new(profile_params)

    if @profile.save
      redirect_to [current_user, @profile], notice: 'Profile was successfully created.'
    else
      render :new
    end
  end

  def update
    if @profile.update(profile_params)
      redirect_to [current_user, @profile], notice: 'Profile was successfully updated.'
    else
      render :edit
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
    params.require(:profile).permit(:name, :bio).merge(user_id: current_user.id)
  end
end
