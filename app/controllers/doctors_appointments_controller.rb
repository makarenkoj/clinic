class DoctorsAppointmentsController < ApplicationController
  before_action :authenticate_user!

  def index
    # TODO
  end

  def show
    @appointment = DoctorsAppointment.find(params[:id])

    access_right_check

    @doctor_profile = @appointment.doctor_profile
    @patient_profile = @appointment.patient_profile
  end

  def new
    @appointment = current_user.patient_profile.doctors_appointments.build
    @doctor = DoctorProfile.find_by(id: params[:doctor_id])
  end

  def create
    user_doctor = User.doctor.find_by(username: params[:doctors_appointment][:doctor_profile].downcase) # Username

    return redirect_to doctor_profiles_url, notice: t('errors.no_such_doctor') unless user_doctor&.doctor_profile.present?

    properties = doctors_appointment_params.merge(doctor_profile: user_doctor&.doctor_profile, patient_profile: current_user.patient_profile)

    appointment = DoctorsAppointment.new(properties)

    if appointment.save
      redirect_to current_user.patient_profile, notice: t('controllers.appointments.created')
    else
      redirect_to new_doctors_appointment_url, notice: errors_message_html(appointment.errors)
    end
  end

  def edit
    @appointment = DoctorsAppointment.find(params[:id])
  end

  # rubocop:disable Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/PerceivedComplexity
  def update
    @appointment = DoctorsAppointment.find(params[:id])

    unless current_user&.doctor_profile&.doctors_appointments&.include?(@appointment) || current_user&.patient_profile&.doctors_appointments&.include?(@appointment)
      redirect_to root_url, notice: t('errors.not_your_appointment')
    end

    if @appointment.update(doctors_appointment_params)
      redirect_to @appointment, notice: t('controllers.appointments.updated')
    else
      render :edit
    end
  end
  # rubocop:enable Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/PerceivedComplexity

  private

  def access_right_check
    return if current_user == @appointment.doctor_profile.user || @appointment.patient_profile.user

    redirect_to root_url, notice: t('errors.not_your_appointment')
  end

  def doctors_appointment_params
    params.require(:doctors_appointment).permit(:visit_time, :description)
  end
end
