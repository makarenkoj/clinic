class UsersMailerPreview < ActionMailer::Preview
  def patient_new_appointment_email
    appointment = DoctorsAppointment.last

    UsersMailer.with(appointment_id: appointment.id).patient_new_appointment_email
  end

  def doctor_new_appointment_email
    appointment = DoctorsAppointment.last

    UsersMailer.with(appointment_id: appointment.id).doctor_new_appointment_email
  end
end
