class DoctorsAppointment < ApplicationRecord
  belongs_to :doctor_profile
  belongs_to :patient_profile
end
