class DoctorsAppointment < ApplicationRecord
  belongs_to :doctor_profile
  belongs_to :patient_profile

  validates :visit_time, presence: true
  # TODO: validate :doctors_count_validation
end
