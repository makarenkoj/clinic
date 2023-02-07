class DoctorsAppointment < ApplicationRecord
  DOCTORS_COUNT = 10

  belongs_to :doctor_profile
  belongs_to :patient_profile

  validates :visit_time, presence: true
  validate :visit_time_validation
  validate :doctors_count_validation

  private

  # rubocop:disable Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/PerceivedComplexity
  def doctors_count_validation
    return unless doctor_profile.present?

    if doctor_profile&.doctors_appointments&.select { |ap| ap.visit_time.strftime('%d.%m.%y') == visit_time.strftime('%d.%m.%y') }&.size&.>= DOCTORS_COUNT
      errors.add(:visit_time, I18n.t('activerecord.errors.models.appointment.attributes.day_busy', day: visit_time.strftime('%d.%m.%y')))
    end

    doctor_profile.doctors_appointments.each do |a|
      next unless a.visit_time.strftime('%d.%m.%y %H:%M') == visit_time.strftime('%d.%m.%y %H:%M')

      errors.add(:visit_time, 
                 I18n.t('activerecord.errors.models.appointment.attributes.time_busy', 
                        time: visit_time.strftime('%d.%m.%y %H:%M')))
    end
  end
  # rubocop:enable Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/PerceivedComplexity

  def visit_time_validation
    return unless visit_time.present?

    errors.add(:visit_time, I18n.t('activerecord.errors.models.appointment.attributes.visit_time')) if visit_time <= Time.current
  end
  
  def appointment_search_by_doctor_id(id)
    DoctorsAppointment.joins('LEFT JOIN doctor_profiles ON doctor_profiles.id = doctors_appointments.doctor_profile_id').where('doctor_profiles.id = ?', id)
  end
end
