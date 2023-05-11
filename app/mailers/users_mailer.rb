class UsersMailer < ApplicationMailer
  def patient_new_appointment_email
    @appointment = DoctorsAppointment.find(params[:appointment_id])
    @patient = @appointment.patient_profile
    @doctor = @appointment.doctor_profile
    @recipient = User.find(@patient.user_id)

    mail_active_recipient_only(@recipient, subject: I18n.t('mailers.subjects.patient_new_appointment_email'))
  end

  def doctor_new_appointment_email
    @appointment = DoctorsAppointment.find(params[:appointment_id])
    @patient = @appointment.patient_profile
    @doctor = @appointment.doctor_profile
    @recipient = User.find(@doctor.user_id)

    mail_active_recipient_only(@recipient, subject: I18n.t('mailers.subjects.doctor_new_appointment_email'))
  end
end
