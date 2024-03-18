class DoctorProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_doctor!, except: %i[index show]

  def index
    @doctor_profiles = DoctorProfile.order(:created_at).paginate(page: params[:page])
  end

  def show
    @doctor_profile = DoctorProfile.find(params[:id])
  end

  def edit
    @doctor_profile = DoctorProfile.find(params[:id])
    redirect_to current_user, notice: t('controllers.profile.not_your') unless @doctor_profile.user == current_user
  end

  def update
    update_profile_categories

    @doctor_profile = DoctorProfile.find(params[:id])

    if @doctor_profile.update(doctor_profile_params)
      redirect_to @doctor_profile, notice: t('controllers.users.updated')
    else
      render :edit
    end
  end

  private

  def update_profile_categories
    category = Category.find_by(name_ua: params[:doctor_profile][:categories])
    doctor_profile = DoctorProfile.find(params[:id])
    return unless category.present? && doctor_profile.present?

    doctor_profile.categories << category unless doctor_profile.category_ids.include?(category.id)

    doctor_profile.save!
  end

  def doctor_profile_params
    params.require(:doctor_profile).permit(:description, category_ids: [])
  end
end
