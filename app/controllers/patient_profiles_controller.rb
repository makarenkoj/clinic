class PatientProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_patient!, except: %i[index show]

  def index
    if current_user.doctor?
      @patient_profiles = PatientProfile.order(updated_at: params_order).paginate(page: params[:page])
    else
      redirect_to doctor_profiles_url, notice: t('controllers.profile.not_a_doctor')
    end
  end

  def show
    @patient_profile = PatientProfile.find(params[:id])

    if current_user.doctor? || current_user.patient_profile == @patient_profile
      @patient_profile
    else
      redirect_to patient_profile_url(current_user.patient_profile.id), notice: t('controllers.profile.not_a_doctor')
    end
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
