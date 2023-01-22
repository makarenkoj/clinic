class PatientProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_patient!, except: %i[index show]

  def index
    @patient_profiles = PatientProfile.all
  end

  def show
    @patient_profile = PatientProfile.find(params[:id])
  end

  def edit
    @patient_profile = PatientProfile.find(params[:id])
    redirect_to current_user, notice: t('controllers.profile.not_your') unless @patient_profile.user == current_user
  end

  def update
    @patient_profile = PatientProfile.find(params[:id])
    
    if @patient_profile.update(patient_profile_params)
      redirect_to @patient_profile, notice: t('controllers.users.updated')
    else
      render :edit
    end
  end

  private

  def patient_profile_params
    params.require(:patient_profile).permit(:description)
  end
end
