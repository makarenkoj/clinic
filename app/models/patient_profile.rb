class PatientProfile < ApplicationRecord
  belongs_to :user

  has_many :doctors_appointments
  has_many :doctor_profiles, through: :doctors_appointments
end
