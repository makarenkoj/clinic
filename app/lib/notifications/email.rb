module Notifications
  class Email
    class << self
      def send_new_appointment_email(appointment_id:)
        UsersMailer.with(appointment_id: appointment_id).patient_new_appointment_email.deliver_later
        UsersMailer.with(appointment_id: appointment_id).doctor_new_appointment_email.deliver_later
      end

      def send_remaind_appointment_email(appointment_id:)
        UsersMailer.with(appointment_id: appointment_id).patient_remaind_appointment_email.deliver_now
        UsersMailer.with(appointment_id: appointment_id).doctor_remaind_appointment_email.deliver_now
      end
    end
  end
end
