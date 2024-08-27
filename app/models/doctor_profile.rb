class DoctorProfile < ApplicationRecord
  belongs_to :user

  has_many :categories_doctors, dependent: :destroy
  has_many :categories, through: :categories_doctors

  has_many :doctors_appointments
  has_many :patient_profiles, through: :doctors_appointments

  LIMIT = 10

  scope :paginate, lambda { |page:, per_page: LIMIT|
    page = (page || 1).to_i
    current_scope = limit(per_page).offset((page - 1) * per_page)

    PaginationResultService.new(current_scope).tap do |result|
      result.current_page = page
      result.total_pages = (count / per_page.to_f).ceil
    end
  }
end
