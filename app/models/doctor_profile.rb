class DoctorProfile < ApplicationRecord
  belongs_to :user

  has_many :categories_doctors, dependent: :destroy
  has_many :categories, through: :categories_doctors

  has_many :doctors_appointments
  has_many :patient_profiles, through: :doctors_appointments
end
