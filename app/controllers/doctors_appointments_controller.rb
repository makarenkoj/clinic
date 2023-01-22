class DoctorsAppointmentsController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def show
    @appointment = DoctorsAppointment.find(params[:id])

    access_right_check

    @doctor_profile = @appointment.doctor_profile
    @patient_profile = @appointment.patient_profile
  end

  def new
    binding.break

    @appointment = current_user.patient_profile.doctors_appointment.build
  end

  def create
    binding.break
    @appointment
  end

  def edit
    @appointment = DoctorsAppointment.find(params[:id])
  end

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

  private

  def access_right_check
    return if current_user == @appointment.doctor_profile.user || @appointment.patient_profile.user

    redirect_to root_url, notice: t('errors.not_your_appointment')
  end

  def doctors_appointment_params
    params.require(:doctors_appointment).permit(:visit_time, :description)
  end
end
