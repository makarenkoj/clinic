class PlacesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_doctor!, only: %i[create update destroy]

  def show
    @place = Place.find(params[:id])
  end

  def new
    @doctor_profile = DoctorProfile.find(current_user.doctor_profile.id)
    @place = @doctor_profile.build_place
  end

  def edit
    @place = Place.find(params[:id])
    redirect_to current_user, notice: t('controllers.profile.not_your') unless @place.doctor_profile.user == current_user
  end

  def create
    @doctor_profile = DoctorProfile.find(current_user.doctor_profile.id)
    @place = @doctor_profile.build_place(place_params)

    if @place.save
      PlaceCoordinatesJob.perform_later(@place.id)
      redirect_to doctor_profile_place_path(@doctor_profile.id, @place.id), notice: t('places.created')
    else
      render :new, notice: t('places.not_created')
    end
  end

  def update
    @doctor_profile = DoctorProfile.find(current_user.doctor_profile.id)
    @place = Place.find(params[:id])
    old_location = @place.location

    if @place.update(place_params)
      PlaceCoordinatesJob.perform_later(@place.id) if old_location != @place.location
      redirect_to doctor_profile_place_path(@doctor_profile.id, @place.id), notice: t('places.updated')
    else
      render :edit, notice: t('places.not_updated')
    end
  end

  def destroy
    @place = Place.find(params[:id])
    @doctor_profile = DoctorProfile.find(current_user.doctor_profile.id)

    if @doctor_profile.place != @place
      redirect_to doctor_profile_path(@doctor_profile.id), notice: t('places.not_your')
      return
    end

    if @place.destroy
      redirect_to doctor_profile_path(@doctor_profile.id), notice: t('places.destroyed')
    else
      redirect_to doctor_profile_place_path(@doctor_profile.id, @place.id), notice: t('places.not_deleted')
    end
  end

  private

  def place_params
    params.require(:place).permit(:doctor_profile_id, :name, :location, :x, :y)
  end
end
