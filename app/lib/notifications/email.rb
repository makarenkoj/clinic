module Notifications
  class Email
    class << self
      def send_new_appointment_email(appointment_id:)
        UsersMailer.with(appointment_id: appointment_id).patient_new_appointment_email.deliver_later
        UsersMailer.with(appointment_id: appointment_id).doctor_new_appointment_email.deliver_later
      end
    end
  end
end
