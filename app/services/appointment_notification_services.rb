class AppointmentNotificationServices
  START_TIME = Time.now + 30.minutes
  END_TIME = Time.now + 1.hour

  def self.call
    appointments.each do |appointment|
      Notifications::Email.send_remaind_appointment_email(appointment_id: appointment.id)
    end
  end

  def self.appointments
    DoctorsAppointment.where('visit_time >= ? AND visit_time <= ?', START_TIME, END_TIME)
  end
end
