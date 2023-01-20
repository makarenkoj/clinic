class DoctorProfilesController < ApplicationController
  before_action :authenticate_user!, except: %i[show]
  before_action :check_doctor!, except: %i[show]

  def show
    @doctor_profile = DoctorProfile.find(params[:id])
  end

  def edit
    @doctor_profile = DoctorProfile.find(params[:id])
    redirect_to current_user, notice: t('controllers.profile.not_your') unless @doctor_profile.user == current_user
  end

  def update
    @doctor_profile = DoctorProfile.find(params[:id])
    
    if @doctor_profile.update(doctor_profile_params)
      redirect_to @doctor_profile, notice: t('controllers.users.updated')
    else
      render :edit
    end
  end

  def destroy
    @doctor_profile = DoctorProfile.find(params[:id])
    redirect_to current_user, notice: t('controllers.profile.not_your') unless @doctor_profile.user == current_user

    @doctor_profile.destroy
    redirect_to root_path, notice: t('controllers.users.destroyed')
  end

  private

  def doctor_profile_params
    params.require(:doctor_profile).permit(:description)
  end
end
